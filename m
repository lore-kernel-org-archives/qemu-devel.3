Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgs2-00088O-UX; Thu, 30 May 2024 10:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCgs0-0007zp-RV
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCgrv-0006eu-R0
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717079700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/bSNLE6vRMxIhWWHa3sXbymBPDbm7q+oYFGxKXhdCU=;
 b=eYBNGptTlcKliiLLu4RWg0F/2MLEuvzG0e5bcZCCV3UhM3eX+22jtEgyQ0i8Vl2I/hH8tY
 nVRiw13ST4A2jGNtSRqh7BnGThLaS8POO+zh9YtmwgmM1Khah3mC73L5GJvPzzTWBbRNfg
 lXsAAnJjiKI6qUS/wgqKxxZZZ4INjFY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-YpjsegHHNZOzS-vzAVEkQw-1; Thu, 30 May 2024 10:34:59 -0400
X-MC-Unique: YpjsegHHNZOzS-vzAVEkQw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42117a61bccso8638995e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717079698; x=1717684498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/bSNLE6vRMxIhWWHa3sXbymBPDbm7q+oYFGxKXhdCU=;
 b=d0Q45fjDcGvftQM/wXVnYrFz1w7kxOJswNHjsenxjiMgb96CspQPqG+TiU29kqbeeu
 OqkioPId89RJK4lzfvk+NQcDG4g03TG3xCCyvBhOSLEE9wqseipuUNFcDy+1pd+ALCzm
 T3/TdkN4nymTA+y7yANqMWixjPR1lfOylQGR8LwsZUyBf+V538+/KGFmjtoiH1rFWBR/
 +eggeiy90lOokb0Fkxq6rjThrOnN/RJDNeHStryyUyBp1W1AYmTV/Ekcn57xw7udoJ/s
 M+e4o2RY9O7hmud8VpV4+vUqp18/y+aaLeOv6ojCxVTeKPO7ilN93LUbesTmSj6QaME/
 ih+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVysU4SiEmStKi4Sq2h+T48GgWTyFzmYRlqf8f+aOl1/EwsC4AQMT/MUpZZmwIeYpCnVDGsWSmyRE47c6HO2xcrh2OpGn8=
X-Gm-Message-State: AOJu0Yx9jTOZwHgPTpCnfkYQ/H0PIQS7hRktpzMLrF4Zml+8+YjSEGFj
 aIlBWDfZHJ0la2nWpedN5wOxpiE63uH9o4HzxljXqBSxx+jfuiMmoLxiD7n1ZWKPgPu6D1z9Y8x
 N4o1rXxJCT3mllev4sLMR3OJbTjhhDw9ZeQTjXUpzNPGVjR+XWSOg
X-Received: by 2002:a05:600c:190e:b0:416:9ba0:8f17 with SMTP id
 5b1f17b1804b1-4212781b22cmr22750655e9.22.1717079698144; 
 Thu, 30 May 2024 07:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeDhjVADL1qQ2SQ5bn6wm7sn743EDitHjovG00/VGeK3xOmUrSug7+0zwT8WqBysCG0NtYYA==
X-Received: by 2002:a05:600c:190e:b0:416:9ba0:8f17 with SMTP id
 5b1f17b1804b1-4212781b22cmr22750335e9.22.1717079697601; 
 Thu, 30 May 2024 07:34:57 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7da35sm17617315f8f.16.2024.05.30.07.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 07:34:57 -0700 (PDT)
Date: Thu, 30 May 2024 16:34:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org, Sean Christopherson
 <seanjc@google.com>
Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
Message-ID: <20240530163455.0c70edcc@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZliFJyRhnSVlNOYQ@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
 <29944dba-7005-496d-81ff-1cbc77c67f15@intel.com>
 <20240529144634.40aa597f@imammedo.users.ipa.redhat.com>
 <898effa1-1a5b-42c0-9305-8db8d5febbf5@intel.com>
 <ZliFJyRhnSVlNOYQ@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 30 May 2024 21:54:47 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Zide,
> 
> On Wed, May 29, 2024 at 10:31:21AM -0700, Chen, Zide wrote:
> > Date: Wed, 29 May 2024 10:31:21 -0700
> > From: "Chen, Zide" <zide.chen@intel.com>
> > Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
> > 
> > 
> > 
> > On 5/29/2024 5:46 AM, Igor Mammedov wrote:  
> > > On Tue, 28 May 2024 11:16:59 -0700
> > > "Chen, Zide" <zide.chen@intel.com> wrote:
> > >   
> > >> On 5/28/2024 2:23 AM, Igor Mammedov wrote:  
> > >>> On Fri, 24 May 2024 13:00:14 -0700
> > >>> Zide Chen <zide.chen@intel.com> wrote:
> > >>>     
> > >>>> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
> > >>>> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
> > >>>> guest and executing MWAIT/MONITOR on the guest triggers #UD.    
> > >>>
> > >>> this is missing proper description how do you trigger issue
> > >>> with reproducer and detailed description why guest sees MWAIT
> > >>> when it's not supported by host.    
> > >>
> > >> If "overcommit cpu-pm=on" and "-cpu host" are present, as shown in the  
> > > it's bette to provide full QEMU CLI and host/guest kernels used and what
> > > hardware was used if it's relevant so others can reproduce problem.  
> > 
> > I ever reproduced this on an older Intel Icelake machine, a
> > Sapphire Rapids and a Sierra Forest, but I believe this is a x86 generic
> > issue, not specific to particular models.
> > 
> > For the CLI, I think the only command line options that matter are
> >  -overcommit cpu-pm=on: to set enable_cpu_pm
> >  -cpu host: so that cpu->max_features is set
> > 
> > For QEMU version, as long as it's after this commit: 662175b91ff2
> > ("i386: reorder call to cpu_exec_realizefn")
> > 
> > The guest fails to boot:
> > 
> > [ 24.825568] smpboot: x86: Booting SMP configuration:
> > [ 24.826377] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12
> > #13 #14 #15 #17
> > [ 24.985799] .... node #1, CPUs: #128 #129 #130 #131 #132 #133 #134 #135
> > #136 #137 #138 #139 #140 #141 #142 #143 #145
> > [ 25.136955] invalid opcode: 0000 1 PREEMPT SMP NOPTI
> > [ 25.137790] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0 #2
> > [ 25.137790] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/04
> > [ 25.137790] RIP: 0010:mwait_idle+0x35/0x80
> > [ 25.137790] Code: 6f f0 80 48 02 20 48 8b 10 83 e2 08 75 3e 65 48 8b 15
> > 47 d6 56 6f 48 0f ba e2 27 72 41 31 d2 48 89 d8
> > [ 25.137790] RSP: 0000:ffffffff91403e70 EFLAGS: 00010046
> > [ 25.137790] RAX: ffffffff9140a980 RBX: ffffffff9140a980 RCX:
> > 0000000000000000
> > [ 25.137790] RDX: 0000000000000000 RSI: ffff97f1ade21b20 RDI:
> > 0000000000000004
> > [ 25.137790] RBP: 0000000000000000 R08: 00000005da4709cb R09:
> > 0000000000000001
> > [ 25.137790] R10: 0000000000005da4 R11: 0000000000000009 R12:
> > 0000000000000000
> > [ 25.137790] R13: ffff98573ff90fc0 R14: ffffffff9140a038 R15:
> > 0000000000093ff0
> > [ 25.137790] FS: 0000000000000000(0000) GS:ffff97f1ade00000(0000)
> > knlGS:0000000000000000
> > [ 25.137790] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 25.137790] CR2: ffff97d8aa801000 CR3: 00000049e9430001 CR4:
> > 0000000000770ef0
> > [ 25.137790] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [ 25.137790] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> > 0000000000000400
> > [ 25.137790] PKRU: 55555554
> > [ 25.137790] Call Trace:
> > [ 25.137790] <TASK>
> > [ 25.137790] ? die+0x37/0x90
> > [ 25.137790] ? do_trap+0xe3/0x110
> > [ 25.137790] ? mwait_idle+0x35/0x80
> > [ 25.137790] ? do_error_trap+0x6a/0x90
> > [ 25.137790] ? mwait_idle+0x35/0x80
> > [ 25.137790] ? exc_invalid_op+0x52/0x70
> > [ 25.137790] ? mwait_idle+0x35/0x80
> > [ 25.137790] ? asm_exc_invalid_op+0x1a/0x20
> > [ 25.137790] ? mwait_idle+0x35/0x80
> > [ 25.137790] default_idle_call+0x30/0x100
> > [ 25.137790] cpuidle_idle_call+0x12c/0x170
> > [ 25.137790] ? tsc_verify_tsc_adjust+0x73/0xd0
> > [ 25.137790] do_idle+0x7f/0xd0
> > [ 25.137790] cpu_startup_entry+0x29/0x30
> > [ 25.137790] rest_init+0xcc/0xd0
> > [ 25.137790] start_kernel+0x396/0x5d0
> > [ 25.137790] x86_64_start_reservations+0x18/0x30
> > [ 25.137790] x86_64_start_kernel+0xe7/0xf0
> > [ 25.137790] common_startup_64+0x13e/0x148
> > [ 25.137790] </TASK>
> > [ 25.137790] Modules linked in:
> > [ 25.137790] --[ end trace 0000000000000000 ]--
> > [ 25.137790] invalid opcode: 0000 2 PREEMPT SMP NOPTI
> > [ 25.137790] RIP: 0010:mwait_idle+0x35/0x80
> > [ 25.137790] Code: 6f f0 80 48 02 20 48 8b 10 83 e2 08 75 3e 65 48 8b 15
> > 47 d6 56 6f 48 0f ba e2 27 72 41 31 d2 48 89 d8
> >   
> > >   
> > >> following, CPUID_EXT_MONITOR is set after x86_cpu_filter_features(), so
> > >> that it doesn't have a chance to check MWAIT against host features and
> > >> will be advertised to the guest regardless of whether it's supported by
> > >> the host or not.
> > >>
> > >> x86_cpu_realizefn()
> > >>   x86_cpu_filter_features()
> > >>   cpu_exec_realizefn()
> > >>     kvm_cpu_realizefn
> > >>       host_cpu_realizefn
> > >>         host_cpu_enable_cpu_pm
> > >>           env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> > >>
> > >>
> > >> If it's not supported by the host, executing MONITOR or MWAIT
> > >> instructions from the guest triggers #UD, no matter MWAIT_EXITING
> > >> control is set or not.  
> > > 
> > > If I recall right, kvm was able to emulate mwait/monitor.
> > > So question is why it leads to exception instead?  
> > 
> > KVM can come to play only iff it can trigger MWAIT/MONITOR VM exits. I
> > didn't find explicit proof from Intel SDM that #UD exceptions take
> > precedence over MWAIT/MONITOR VM exits, but this is my speculation. For
> > example, in ancient machines which don't support MWAIT yet, the only way
> > it can do is #UD, not MWAIT VM exit?  
> 
> For the Host which doesn't support MWAIT, it shouldn't have the VMX
> control bit for mwait exit either, right?
> 
> Could you pls check this on your machine? If VMX doesn't support this
> exit event, then triggering an exception will make sense.

My assumption (probably wrong) was that KVM would emulate mwait if it's unavailable,
unless we have KVM_CAP_X86_DISABLE_EXITS enabled. And in the later case it would
explode as expected, however then we shouldn't be able to set KVM_CAP_X86_DISABLE_EXITS
to begin with.

Recently Sean posted a patch related to that
[PATCH v2 12/49] KVM: x86: Reject disabling of MWAIT/HLT interception when not allowed
  https://lkml.org/lkml/2024/5/17/729

This needs someone with KVM expertise to chime in
Perhaps Paolo/Sean could clarify expected behavior.




