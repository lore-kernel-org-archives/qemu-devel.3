Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19C6C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 01:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s34Or-0007g9-OU; Fri, 03 May 2024 21:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1s34On-0007f5-Ja
 for qemu-devel@nongnu.org; Fri, 03 May 2024 21:41:13 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1s34Ol-0001sy-Du
 for qemu-devel@nongnu.org; Fri, 03 May 2024 21:41:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so40090166b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1714786869; x=1715391669; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cMaSACtjO3SUkgFNE0eUoOTbz0mIrS43V9gIJCsSjMw=;
 b=Tm+x6g3uquRdLWEaDCV1sDPeWQ9/odIp75WT4cU4MIAv5LxqR4CXo42KgtqKbq3juD
 1APx9TxKrB65jav5ndnlOLSsj+Eux7YtcIvtWnsEpKcsEk/lnli20NWG2ZJhRuIq5loT
 7NxBmbg3U6D+miMloyfs2wf0s2m8YfNfecyiYJ28EN20Ke5B2+tW42UFJ59hbuSFH7cz
 r7BTA1pwJqglNMQnnHVJvaApvIFhNioiQecUiClbZrlOFx5w+k3ImDhozIf8AOhpGYiQ
 X99Af2T/uO5fIdtctiqsGcYm66eoYJSNOuEfJwyCuvPuxD0bs/MM4StKkb0pU1V9UuCw
 +LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714786869; x=1715391669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMaSACtjO3SUkgFNE0eUoOTbz0mIrS43V9gIJCsSjMw=;
 b=T4WEoT9zZhtiv4pH168TkhbeOWW/JonE6cp49w02lxTU9K0Tu6FtA6pAtxfj8aRYvj
 DnQ0irR1b+x4XD6HrTrSpAPE3GBAQ6gz4X13guAACc4wkQoVuuiCpcOebxI97Xas8xWd
 4NUON2QC2787CBYEgxvHH3YL75xI4Qlo61r1ok9gaaiUYTui2wCq3+KfaTwxKW3TQ9EM
 F5+zxSCKOTXTGq8epHVfVJw27WgOxptQnZkxrSRdAnoWadlUn8GSAhZbKfMxB9sXOf3N
 uQ9LH3H2hXal5SfzYX62uGzxPeEO2bH4nw5Q2Rj6lyb+jt5hvV1NklwXAXbjOj6YjNnd
 OONQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVenjNQJqPBapA4IediSFYArMCRi2LQq6QkVVSn9d0T39BuCAKv8TH8UQWMKzXYTGIgsWP5HLpVgYKoWiXJnbbfNDRJkd4=
X-Gm-Message-State: AOJu0YzqupAwqAp90pWtZ3+/pdDBNNXgvrjWG7esmBJtpf6DfD+kKO54
 GcNBoU+XuA8z0tarFoDKcWFlBfBwrQDIBIbpaST1Bl8cE6bxrSXz4D1zO9a7mn7NbMQPyViKE+p
 SHkkPm7ZdsCI9F6Qh59UFg2QRt5+JXeNq7E7k1Q==
X-Google-Smtp-Source: AGHT+IHjmytAzojMfNdYwcFmfP1vW50Hh3Q+jDWe+k2a+JTyeZh4d7TBP15mECEOVzFwePmUI2mZfJryFWNQJZ5yAHI=
X-Received: by 2002:a17:906:52cc:b0:a59:9f11:2b66 with SMTP id
 w12-20020a17090652cc00b00a599f112b66mr974332ejn.36.1714786869051; Fri, 03 May
 2024 18:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
 <7bccde5479f044dc87679236b736b861@huawei.com>
In-Reply-To: <7bccde5479f044dc87679236b736b861@huawei.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Sat, 4 May 2024 02:40:57 +0100
Message-ID: <CAJ7pxebK_rPFYN_NVLUyAVExb+e0ep7Bx5BuPgRJcmg9s5BQBQ@mail.gmail.com>
Subject: Re: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
To: zhukeqian <zhukeqian1@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, 
 "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, 
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "Wanghaibin (D)" <wanghaibin.wang@huawei.com>, 
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 Linuxarm <linuxarm@huawei.com>, yuzenghui <yuzenghui@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000321bd9061796eeec"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000321bd9061796eeec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhukeqian,

On Fri, Mar 15, 2024 at 1:17=E2=80=AFAM zhukeqian <zhukeqian1@huawei.com> w=
rote:

> Hi Salil,
>
> [...]
>
> +void cpu_address_space_destroy(CPUState *cpu, int asidx) {
> +    CPUAddressSpace *cpuas;
> +
> +    assert(cpu->cpu_ases);
> +    assert(asidx >=3D 0 && asidx < cpu->num_ases);
> +    /* KVM cannot currently support multiple address spaces. */
> +    assert(asidx =3D=3D 0 || !kvm_enabled());
> +
> +    cpuas =3D &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);
>
> In address_space_destroy(), it calls call_rcu1() on cpuas->as which will
> set do_address_space_destroy() as the rcu func.
> And g_free_rcu() also calls call_rcu1() on cpuas->as which will overwrite
> the rcu func as g_free().
>
> Then I think the g_free() may be called twice in rcu thread, please verif=
y
> that.
>
> The source code of call_rcu1:
>
> void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node)=
)
> {
>     node->func =3D func;
>     enqueue(node);
>     qatomic_inc(&rcu_call_count);
>     qemu_event_set(&rcu_call_ready_event);
> }
>


Thanks for testing and identifying this. Let me have a look and will get
back to you.

Thanks
Salil



>
> Thanks,
> Keqian
>
> +
> +    if (asidx =3D=3D 0) {
> +        /* reset the convenience alias for address space 0 */
> +        cpu->as =3D NULL;
> +    }
> +
> +    if (--cpu->cpu_ases_count =3D=3D 0) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases =3D NULL;
> +    }
> +}
> +
>  AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)  {
>      /* Return the AddressSpace corresponding to the specified index */
> --
> 2.34.1
>
>

--000000000000321bd9061796eeec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Zhukeqian,</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 15, 2024 at 1:17=
=E2=80=AFAM zhukeqian &lt;<a href=3D"mailto:zhukeqian1@huawei.com">zhukeqia=
n1@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi Salil,<br>
<br>
[...]<br>
<br>
+void cpu_address_space_destroy(CPUState *cpu, int asidx) {<br>
+=C2=A0 =C2=A0 CPUAddressSpace *cpuas;<br>
+<br>
+=C2=A0 =C2=A0 assert(cpu-&gt;cpu_ases);<br>
+=C2=A0 =C2=A0 assert(asidx &gt;=3D 0 &amp;&amp; asidx &lt; cpu-&gt;num_ase=
s);<br>
+=C2=A0 =C2=A0 /* KVM cannot currently support multiple address spaces. */<=
br>
+=C2=A0 =C2=A0 assert(asidx =3D=3D 0 || !kvm_enabled());<br>
+<br>
+=C2=A0 =C2=A0 cpuas =3D &amp;cpu-&gt;cpu_ases[asidx];<br>
+=C2=A0 =C2=A0 if (tcg_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_listener_unregister(&amp;cpuas-&gt;tcg_=
as_listener);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 address_space_destroy(cpuas-&gt;as);<br>
+=C2=A0 =C2=A0 g_free_rcu(cpuas-&gt;as, rcu);<br>
<br>
In address_space_destroy(), it calls call_rcu1() on cpuas-&gt;as which will=
 set do_address_space_destroy() as the rcu func.<br>
And g_free_rcu() also calls call_rcu1() on cpuas-&gt;as which will overwrit=
e the rcu func as g_free().<br>
<br>
Then I think the g_free() may be called twice in rcu thread, please verify =
that.<br>
<br>
The source code of call_rcu1:<br>
<br>
void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))<=
br>
{<br>
=C2=A0 =C2=A0 node-&gt;func =3D func;<br>
=C2=A0 =C2=A0 enqueue(node);<br>
=C2=A0 =C2=A0 qatomic_inc(&amp;rcu_call_count);<br>
=C2=A0 =C2=A0 qemu_event_set(&amp;rcu_call_ready_event);<br>
}<br></blockquote><div><br></div><div><br></div><div>Thanks for testing and=
 identifying this. Let me have a look and will get back to you.</div><div><=
br></div><div>Thanks</div><div>Salil</div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Keqian<br>
<br>
+<br>
+=C2=A0 =C2=A0 if (asidx =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* reset the convenience alias for address spa=
ce 0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;as =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (--cpu-&gt;cpu_ases_count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cpu-&gt;cpu_ases);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cpu_ases =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)=C2=A0 {=
<br>
=C2=A0 =C2=A0 =C2=A0/* Return the AddressSpace corresponding to the specifi=
ed index */<br>
--<br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000321bd9061796eeec--

