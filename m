Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DADC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE41X-0003Nk-Is; Mon, 03 Jun 2024 05:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sE41V-0003NK-Bd
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sE41T-0001y7-AK
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717407033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DsO/wSko+ht7cFmMUZz3+K0/TmcYz1qinhmmuMP/d0=;
 b=I+HKk5EZeMAFoK9exAuV7P3jac5rt3Ws8y3MyJ7wX7eVsC0RGL/TAv9SgbfHQIKITO+n8S
 dYgObbkggPaqpJI6cYOUbxWSckPRypIilGa8S4Ri4+fU3tatItEtLO5hbSTlMZjR+vsdU+
 mTrWMgqdi5crK37Vn/jTO31zmMSiTB0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-KcHSBk9SPZe22TXSshTb-w-1; Mon, 03 Jun 2024 05:30:30 -0400
X-MC-Unique: KcHSBk9SPZe22TXSshTb-w-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-681a3f54a5fso3584281a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 02:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717407029; x=1718011829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DsO/wSko+ht7cFmMUZz3+K0/TmcYz1qinhmmuMP/d0=;
 b=IHSrYIIDLwh2JjC4ASZzJzwKyNgm0VQN2Xs/j2apyWojw6PgptJ0uACjWTBWJw4ZCW
 P1iBfG3Z93N8gP8fQcvj/SAKbktOUNlcxN7X5EwP8ocO8vYbgm2tWVmX5e6GQSOpOft+
 7KmHIIG7AZtflCzLci+G0/l3KucZM/VyY+p0tZYagfwXmFX8XIrmqAnwXxsXayeqVrD4
 J7x29/dv5BulDPKto9WfjDiUy7P8+4lWsFcF3dTzd4ZreYJuAtNhR5kOHGJXQ1OwoCvM
 XeEwkEnOzTNjJsR9OnFnW5/6GTKIxJVNQ9B4wXVM5llkRWD7LCsVwg/9uVay6thV2s53
 w8rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvUNQCkMUNwOFuWZ7PgZ/TLPDkzCjmv5pfOx1LUfJjbCL69WZOITZG9+9CW1cY8EAftTv8R0XTpTnZ+m926uebB3EZU0s=
X-Gm-Message-State: AOJu0Yz5SmQxuD7uKjjx459TB2EKPPmY0Qr/dQ/XXTuDaDZKscGKGk3b
 SXmLqDa8Txf1UhJjw6KKwzKbwOA/vXtfxFhu4vnZm0qJpFQnA5MoMrCataJmDVgfgdCh0u6MZa2
 AycfDZiN2xDSfLpP0ZauwOhHMa5CejVIs9qGMIMqNbrFDXSRsB4YW
X-Received: by 2002:a05:6a20:a11e:b0:1b1:d822:d37e with SMTP id
 adf61e73a8af0-1b26f187e2fmr9505441637.32.1717407029252; 
 Mon, 03 Jun 2024 02:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1/duUaWvKPYbODn3GkI1Er1+hbsvZYzfmqm9BL+R0r6XamIWOEL6s5OSZM3iBj/AWeYQDA==
X-Received: by 2002:a05:6a20:a11e:b0:1b1:d822:d37e with SMTP id
 adf61e73a8af0-1b26f187e2fmr9505415637.32.1717407028870; 
 Mon, 03 Jun 2024 02:30:28 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423c7c6dsm5116694b3a.1.2024.06.03.02.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 02:30:28 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:30:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
Message-ID: <20240603113022.6569043b@imammedo.users.ipa.redhat.com>
In-Reply-To: <Zls9v9mg17SXZhO7@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-3-zide.chen@intel.com>
 <ZlluoKXUF6ctecVt@intel.com>
 <04d3dfd8-93d2-493d-82d1-8fbcad6ecd22@intel.com>
 <Zls9v9mg17SXZhO7@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, 1 Jun 2024 23:26:55 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Fri, May 31, 2024 at 10:13:47AM -0700, Chen, Zide wrote:
> > Date: Fri, 31 May 2024 10:13:47 -0700
> > From: "Chen, Zide" <zide.chen@intel.com>
> > Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
> >  x86_cpu_filter_features
> > 
> > On 5/30/2024 11:30 PM, Zhao Liu wrote:  
> > > Hi Zide,
> > > 
> > > On Fri, May 24, 2024 at 01:00:16PM -0700, Zide Chen wrote:  
> > >> Date: Fri, 24 May 2024 13:00:16 -0700
> > >> From: Zide Chen <zide.chen@intel.com>
> > >> Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
> > >>  x86_cpu_filter_features
> > >> X-Mailer: git-send-email 2.34.1
> > >>
> > >> cpu_exec_realizefn which calls the accel-specific realizefn may expand
> > >> features.  e.g., some accel-specific options may require extra features
> > >> to be enabled, and it's appropriate to expand these features in accel-
> > >> specific realizefn.
> > >>
> > >> One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.
> > >>
> > >> Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
> > >> that it won't expose features not supported by the host.
> > >>
> > >> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> > >> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> > >> ---
> > >>  target/i386/cpu.c         | 24 ++++++++++++------------
> > >>  target/i386/kvm/kvm-cpu.c |  1 -
> > >>  2 files changed, 12 insertions(+), 13 deletions(-)
> > >>
> > >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > >> index bc2dceb647fa..a1c1c785bd2f 100644
> > >> --- a/target/i386/cpu.c
> > >> +++ b/target/i386/cpu.c
> > >> @@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> > >>          }
> > >>      }
> > >>  
> > >> +    /*
> > >> +     * note: the call to the framework needs to happen after feature expansion,
> > >> +     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
> > >> +     * These may be set by the accel-specific code,
> > >> +     * and the results are subsequently checked / assumed in this function.
> > >> +     */
> > >> +    cpu_exec_realizefn(cs, &local_err);
> > >> +    if (local_err != NULL) {
> > >> +        error_propagate(errp, local_err);
> > >> +        return;
> > >> +    }
> > >> +
> > >>      x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);  
> > > 
> > > For your case, which sets cpu-pm=on via overcommit, then
> > > x86_cpu_filter_features() will complain that mwait is not supported.
> > > 
> > > Such warning is not necessary, because the purpose of overcommit (from
> > > code) is only to support mwait when possible, not to commit to support
> > > mwait in Guest.
> > > 
> > > Additionally, I understand x86_cpu_filter_features() is primarily
> > > intended to filter features configured by the user,   
> > 
> > Yes, that's why this patches intends to let x86_cpu_filter_features()
> > filter out the MWAIT bit which is set from the overcommit option.  
> 
> HMM, but in fact x86_cpu_filter_features() has already checked the MWAIT
> bit set by "-overcommit cpu-pm=on". ;-)
> 
> (Pls correct me if I'm wrong) Revisiting what cpu-pm did to MWAIT:
> * Firstly, it set MWAIT bit in x86_cpu_expand_features():
>   x86_cpu_expand_features()
>      -> x86_cpu_get_supported_feature_word()
>         -> kvm_arch_get_supported_cpuid()  
>  This MWAIT is based on Host's MWAIT capability. This MWAIT enablement
>  is fine for next x86_cpu_filter_features() and x86_cpu_filter_features()
>  is working correctly here!
> 
> * Then, MWAIT was secondly set in host_cpu_enable_cpu_pm() regardless
>   neither Host's support or previous MWAIT enablement result. This is
>   the root cause of your issue.
> 
> Therefore, we should make cpu-pm honor his first MWAIT enablement result
> instead of repeatly and unconditionally setting the MWAIT bit again in
> host_cpu_enable_cpu_pm().
> 
> Additionally, I think the code in x86_cpu_realizefn():
>   cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
> has the similar issue because it also should check MWAIT feature bit.
> 
> Further, it may be possible to remove cpu->mwait: just check the MWAIT
> bit in leaf 5 of cpu_x86_cpuid(), and if MWAIT is present, use host's
> mwait info plus CPUID_MWAIT_EMX | CPUID_MWAIT_IBE.

Agreed with above analysis,
we shouldn't have host_cpu_enable_cpu_pm() as kvm_arch_get_supported_cpuid
gets us MWAIT already.

filling in cpu->mwait.ecx is benign mistake which likely doesn't
trigger anything if CPUID_EXT_MONITOR is not present.
But for clarity it's better to add an explicit check there as well.

> 
> > > and the changes of
> > > CPUID after x86_cpu_filter_features() should by default be regarded like
> > > "QEMU knows what it is doing".  
> > 
> > Sure, we can add feature bits after x86_cpu_filter_features(), but I
> > think moving cpu_exec_realizefn() before x86_cpu_filter_features() is
> > more generic, and actually this is what QEMU did before commit 662175b91ff2.
> > 
> > - Less redundant code. Specifically, no need to call
> > x86_cpu_get_supported_feature_word() again.
> > - Potentially there could be other features could be added from the
> > accel-specific realizefn, kvm_cpu_realizefn() for example.  And these
> > features need to be checked against the host availability.  
> 
> Mainly I don't think this reorder is a direct fix for the problem (I
> just analyse it above), also in your case x86_cpu_filter_features() will
> print a WARNING when QEMU boots, which I don't think is cpu-pm's intention.

There is no problem with warning, I'd even say it's a good thing.
But you are right reordering just masks the issue.

As for expected behavior, if user asked for "-overcommit cpu-pm=on"
there are 2 options:
   * it's working as expected (mwait exiting is enabled successfully with CPUID MONITOR bit set)
   * QEMU shall fail to start.



