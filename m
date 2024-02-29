Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8098DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhTL-0004Md-D0; Thu, 29 Feb 2024 09:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhTI-0004M2-NV
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:33:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhTG-0007nF-Hp
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:33:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412b88e2f07so6977465e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709217192; x=1709821992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTl3N2THqvGMU4lSJtwwxOyqFSaXMF+EAIhyAHr2gZU=;
 b=ZF2Bz5uUvtLEcv+m9IiYngIH/I7E1woyKo1U3XpV65Bw4JVpbcCVsShM2hdxDANHXF
 94b0nijGtbeyLbFITuRV0943aHj6/g6pPJB280l78lbhY4k4Y5OQXUu4qKGZUHjitumc
 n+es+vnxloFBuwXcth7Xss92+KkVUyoJpzsHYpZ3OQGdm6FzewIeDPjuOx53+Kzh8tVO
 4eZz7K8OZocucCWnNSenRMG7z/T/f7dRf4pbp/ZkCYtv2xW2fnx89T5LVlTQ4/RrPd3H
 cLnPUk6qF/IirVm+KA6DvPyAu6L79n73X3za/fDRFB3GHuqIpYkGM+upZ09Bb0vKZoSh
 XjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709217192; x=1709821992;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oTl3N2THqvGMU4lSJtwwxOyqFSaXMF+EAIhyAHr2gZU=;
 b=xFwrODIFoqfthlIYOw5d2HAyYtCe14oP2QZu0mc8wLJqSjNDuEuOG249Pja9kOjqHf
 Mh1Ef2/hoGtjxUQn1TrNHiT3zFylCpcZwgxaipcPs5BW1vqr7BXN6O7mLWpZmGPjEqjG
 8gyFupmf8n1I3mda+/Or2H8K4shLdMXlGot8Q3HGrryMEZQ+yRvYxZ0Msy5OF445Jm5s
 +RuT7M7K88TM6S30cqUikpFt4qy3obn7YyBd4HVkspMSGtoc2e7OI5FgMkCPTxO4Vbet
 Lo8/xIfVkcBnidqwVwtVSqYTzuLdUiuum2zyoxm+TGeVNsJgCOTNZ/kvvyN3/yFnfxGc
 lV9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGBmA/AqHnEwqAxZxzn20+QAP0b3yL88JaUi025ViVf4rFa7qF7OYZ+x4SPjp52YvoaYXUlZJj/+m2oCqmXYzg8ZlQu3A=
X-Gm-Message-State: AOJu0YyolRJwcydEPICrseoa72SDVDAf1DzadKOgBIM35UFYerHYkwi9
 JfD0YPf9D7+JkAB+R5BPeTBTUwZny0feDCjxgnmmh2+QxgkLTBHxgVxG4C8NWV0wyOvhk03ssZA
 0
X-Google-Smtp-Source: AGHT+IFrL2Fg47e6IWs0lCFazPsvnWz0PLtPYp+Q54PhPVdmIS0gMd9dpK5EWfQb5ILAtCAaZrgl3Q==
X-Received: by 2002:a05:600c:1c0e:b0:412:bb1b:ec3 with SMTP id
 j14-20020a05600c1c0e00b00412bb1b0ec3mr2036774wms.11.1709217191500; 
 Thu, 29 Feb 2024 06:33:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r3-20020adfca83000000b0033d2ae84fafsm1913825wrh.52.2024.02.29.06.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:33:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9382D5F7B0;
 Thu, 29 Feb 2024 14:33:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Luc Michel <luc.michel@amd.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 <qemu-devel@nongnu.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 09/12] contrib/plugins/hotblocks: migrate to new
 per_vcpu API
In-Reply-To: <Zd3xGrZetKoAbIn1@luc-work-vm> (Luc Michel's message of "Tue, 27
 Feb 2024 15:26:34 +0100")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-10-pierrick.bouvier@linaro.org>
 <Zd2_VHB6-G7srfSo@luc-work-vm>
 <e0688c8b-fac2-4b4f-8cda-a0c4f5ee2bf6@linaro.org>
 <Zd3xGrZetKoAbIn1@luc-work-vm>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 14:33:10 +0000
Message-ID: <87il279w7t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Luc Michel <luc.michel@amd.com> writes:

> On 15:09 Tue 27 Feb     , Pierrick Bouvier wrote:
>> On 2/27/24 2:54 PM, Luc Michel wrote:
>> > Hi Pierrick,
>> >=20
>> > On 13:14 Mon 26 Feb     , Pierrick Bouvier wrote:
>> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> > > ---
>> > >   contrib/plugins/hotblocks.c | 50 ++++++++++++++++++++++-----------=
----
>> > >   1 file changed, 30 insertions(+), 20 deletions(-)
>> > >=20
>> > > diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks=
.c
>> > > index 4de1b134944..02bc5078bdd 100644
>> > > --- a/contrib/plugins/hotblocks.c
>> > > +++ b/contrib/plugins/hotblocks.c
>> > > @@ -34,8 +34,8 @@ static guint64 limit =3D 20;
>> > >    */
>> > >   typedef struct {
>> > >       uint64_t start_addr;
>> > > -    uint64_t exec_count;
>> > > -    int      trans_count;
>> > > +    struct qemu_plugin_scoreboard *exec_count;
>> > > +    int trans_count;
>> > >       unsigned long insns;
>> > >   } ExecCount;
>> > >=20
>> > > @@ -43,7 +43,17 @@ static gint cmp_exec_count(gconstpointer a, gcons=
tpointer b)
>> > >   {
>> > >       ExecCount *ea =3D (ExecCount *) a;
>> > >       ExecCount *eb =3D (ExecCount *) b;
>> > > -    return ea->exec_count > eb->exec_count ? -1 : 1;
>> > > +    uint64_t count_a =3D
>> > > +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(ea->exec_cou=
nt));
>> > > +    uint64_t count_b =3D
>> > > +        qemu_plugin_u64_sum(qemu_plugin_scoreboard_u64(eb->exec_cou=
nt));
>> > > +    return count_a > count_b ? -1 : 1;
>> > > +}
>> > > +
>> > > +static void exec_count_free(gpointer key, gpointer value, gpointer =
user_data)
>> > > +{
>> > > +    ExecCount *cnt =3D value;
>> > > +    qemu_plugin_scoreboard_free(cnt->exec_count);
>> > >   }
>> > >=20
>> > >   static void plugin_exit(qemu_plugin_id_t id, void *p)
>> > > @@ -52,7 +62,6 @@ static void plugin_exit(qemu_plugin_id_t id, void =
*p)
>> > >       GList *counts, *it;
>> > >       int i;
>> > >=20
>> > > -    g_mutex_lock(&lock);
>> >=20
>> > I encountered cases before where the vCPUs continue executing while
>> > plugin_exit is called. This can happen e.g., when QEMU calls exit(3)
>> > from one CPU thread. Others will continue to run at the same time the
>> > atexit callbacks are called.
>> >=20
>> > This also means that you can't really free the resources as you do at
>> > the end of plugin_exit.
>> >=20
>>=20
>> Interesting...
>>=20
>> The current documentation [1] mentions it's the right place to free
>> resources, and from what I saw, existing plugins assume this too (see
>> contrib/plugins/cache.c for instance).
>>=20
>> There is probably a bug related to the case you mention, and I'll try to
>> reproduce this, and see if we can have a proper fix.
>>=20
>> I'm not sure that removing cleanup code from existing plugins is the
>> right thing to do at the moment, even though there is an existing issue
>> with some programs.
>
> Yes absolutely. The problem is on the QEMU side. FWIW I tried to fix one
> of those exit cases (semihosted exit syscall) some time ago:
> https://lore.kernel.org/qemu-devel/20220621125916.25257-1-lmichel@kalray.=
eu/

The plugin exit handler should flush all instrumented code:

  /*
   * Handle exit from linux-user. Unlike the normal atexit() mechanism
   * we need to handle the clean-up manually as it's possible threads
   * are still running. We need to remove all callbacks from code
   * generation, flush the current translations and then we can safely
   * trigger the exit callbacks.
   */

  void qemu_plugin_user_exit(void)
  {
      enum qemu_plugin_event ev;
      CPUState *cpu;

      /*
       * Locking order: we must acquire locks in an order that is consistent
       * with the one in fork_start(). That is:
       * - start_exclusive(), which acquires qemu_cpu_list_lock,
       *   must be called before acquiring plugin.lock.
       * - tb_flush(), which acquires mmap_lock(), must be called
       *   while plugin.lock is not held.
       */
      start_exclusive();

      qemu_rec_mutex_lock(&plugin.lock);
      /* un-register all callbacks except the final AT_EXIT one */
      for (ev =3D 0; ev < QEMU_PLUGIN_EV_MAX; ev++) {
          if (ev !=3D QEMU_PLUGIN_EV_ATEXIT) {
              struct qemu_plugin_cb *cb, *next;

              QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next)=
 {
                  plugin_unregister_cb__locked(cb->ctx, ev);
              }
          }
      }
      CPU_FOREACH(cpu) {
          qemu_plugin_disable_mem_helpers(cpu);
      }
      qemu_rec_mutex_unlock(&plugin.lock);

      tb_flush(current_cpu);
      end_exclusive();

      /* now it's safe to handle the exit case */
      qemu_plugin_atexit_cb();
  }

So you shouldn't see any other instrumentation activity after the
end_exclusive. However you may see another thread hit its exist handler
before we complete exiting the system.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

