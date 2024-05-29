Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B2AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIhc-00036V-42; Wed, 29 May 2024 08:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCIhZ-00035J-5K
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCIhW-0007W6-E8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716986800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVMDKm04epXl+SRHoDfd5QIbcdAd2LbbZjlVtYq7c6Y=;
 b=DArfmSmpmSAolCD1x4XbofVY69qsBUuhmRXkHgRYPVj2TCRItrS1PV1Cd9wezA+8eiQtOu
 ucTd9I2jwAT1izeqw/OS/Wur4i1SG2574QvdVATDnBT5s4gx/UH++SO2vNUCTsfguejnpr
 FZxYWEPWQ1Y3zfU9ZE3Vkp1CUkRDQlo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-D9SAnpr0M2aKFVOb4lS0mA-1; Wed, 29 May 2024 08:46:38 -0400
X-MC-Unique: D9SAnpr0M2aKFVOb4lS0mA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2e95ad43650so13207061fa.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 05:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716986797; x=1717591597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVMDKm04epXl+SRHoDfd5QIbcdAd2LbbZjlVtYq7c6Y=;
 b=XlzUZXyRn+OYWBRBB19tBiYywj4QfwL4yxIXUVEXH5R+M5m8dHoILV1RTamoBSBxkE
 T3BqZa7SUQJrjmNNkZPGjiuarzQ9bKL7FMFeYvXRaIx3wjsOgnFUQX/dFMe2I5qhNjIl
 lOd7ib8PmPXODlftyoq3gHHJ/KFnpOMZfUkzheww7KjC/zxRlSxgBMrFj+Jr0+zmpFsj
 YQ0EAAvdvg0sbH4Kf6zEauhpbD+2TwWh92ZuIZlGir2bq9QNsgzn0/4QkVFhkpRcKj+n
 rK6kV8qWMClz/IdzNS50cBFj1uwDY7X2/zKxw+rk4NagCTVUYJuh2R7C7rSk0ndtvfIK
 72Gw==
X-Gm-Message-State: AOJu0Yy5WHvfZXeOpbJZuk+QgV9lnhiTr2hQstxFehgas+fxwWArzISu
 4MuSlz+6Qf7PEjfCWK58V4XexW7tEZiQBMRA0vHW3yjnucZBxxH3O26FG6e6WkXgIjbWffQ5W/6
 baqkPGtVt3AkWJqki7P67ZeGZ0oEpCbUCnAUaFDrjvhsQiDI57FMc
X-Received: by 2002:a05:651c:20f:b0:2e9:8833:adf2 with SMTP id
 38308e7fff4ca-2e98833b01amr31841931fa.8.1716986797346; 
 Wed, 29 May 2024 05:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNPfkBRBLPfW91C+KFvrGA4fXlvgZatsqhvKrg7oItxt91tvdnWQ5gQRFSE5xUnnS79dLBFQ==
X-Received: by 2002:a05:651c:20f:b0:2e9:8833:adf2 with SMTP id
 38308e7fff4ca-2e98833b01amr31841721fa.8.1716986796874; 
 Wed, 29 May 2024 05:46:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42108970967sm179653065e9.17.2024.05.29.05.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 05:46:36 -0700 (PDT)
Date: Wed, 29 May 2024 14:46:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
Message-ID: <20240529144634.40aa597f@imammedo.users.ipa.redhat.com>
In-Reply-To: <29944dba-7005-496d-81ff-1cbc77c67f15@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
 <29944dba-7005-496d-81ff-1cbc77c67f15@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 28 May 2024 11:16:59 -0700
"Chen, Zide" <zide.chen@intel.com> wrote:

> On 5/28/2024 2:23 AM, Igor Mammedov wrote:
> > On Fri, 24 May 2024 13:00:14 -0700
> > Zide Chen <zide.chen@intel.com> wrote:
> >   
> >> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
> >> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
> >> guest and executing MWAIT/MONITOR on the guest triggers #UD.  
> > 
> > this is missing proper description how do you trigger issue
> > with reproducer and detailed description why guest sees MWAIT
> > when it's not supported by host.  
> 
> If "overcommit cpu-pm=on" and "-cpu hpst" are present, as shown in the
it's bette to provide full QEMU CLI and host/guest kernels used and what
hardware was used if it's relevant so others can reproduce problem.

> following, CPUID_EXT_MONITOR is set after x86_cpu_filter_features(), so
> that it doesn't have a chance to check MWAIT against host features and
> will be advertised to the guest regardless of whether it's supported by
> the host or not.
> 
> x86_cpu_realizefn()
>   x86_cpu_filter_features()
>   cpu_exec_realizefn()
>     kvm_cpu_realizefn
>       host_cpu_realizefn
>         host_cpu_enable_cpu_pm
>           env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> 
> 
> If it's not supported by the host, executing MONITOR or MWAIT
> instructions from the guest triggers #UD, no matter MWAIT_EXITING
> control is set or not.

If I recall right, kvm was able to emulate mwait/monitor.
So question is why it leads to exception instead?


