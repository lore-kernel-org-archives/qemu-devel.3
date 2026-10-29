Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD911606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=avBZLQEF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRhN-0000iK-6N; Thu, 29 Oct 2026 11:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMRhH-0000hh-E8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:43 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMRhF-0001yx-NI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:43 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-675676afc3cso2545156d50.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793286340; cv=none;
 d=google.com; s=arc-20260327;
 b=TjVXR7HdL3Q8KKHyVI6I1lhIfR7JZyiQCUaaUAvbZG3A5d/OGOxYntwiOkazGgzHJh
 cLrPtcaQRZ+JpfYzAQRMZQAXsC3P/iCJAPDm7ibT6rrJgleMKG2dIfNFoooKgeoQMX2K
 oKogSYoPVCSdJbG3GCXeDH2r1pj8ccxYt47ec9haXQJFGzJDZfkzDh6L8wDjlCgxAM2O
 eH8LKoNN6hCpqfoOrhBKill5sSlhlvEfIhPvQW8U/52wJtHfayfhisybmhaCJ5QfQt1d
 MGPUDYoxQhfu4M8kKLUdxP0afC73ZUMPqxm/LUWrZDdouv4MkkfJ+50GSkHxnC1qtvOU
 +22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hYnFjfVMRxMQyu1JvJ9tMZoEHvJhC2MVpyrJBN7CJhs=;
 fh=lwNo4EQ0veEovIJHYut/pMA4DT9nM/qSBWNX0IHdr2c=;
 b=Vjv+eofmfSvAK/qgHAC/DFBbKNFcfbjLT+L/pbQPswTAgQDkFLQ5rHFCnV+1SIhnzJ
 W3Vowy3qNEbnFrd873FMg5n/5AP5ZKTffpoUBPAkSz1OC/3ikRQPX5ha6khYpUK22kZF
 j0n95YvpJP+OcOsTmQJsvEf1WaPhpnP6xW3V8crt+2bwMB1pg+M71uIF00/4950cqT57
 3UctgZG/zkrgfrw0IHqzOrhMn1pnIkJiinglAVvzDTuvqUhpclxmwKS0QKnIGyBeKhtS
 L7LoJBk88AHdfmsnExtr1emqEK/OBb0ORVhLjZQW1gIwJ73RB326YgoHt1XdMlhadTg/
 bqBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793286340; x=1793891140; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hYnFjfVMRxMQyu1JvJ9tMZoEHvJhC2MVpyrJBN7CJhs=;
 b=avBZLQEFhFU+QLmJhKotAmC6N26X00l9GX4x1IO679Dayk6VVWN2z0DmK1ADoGQUHT
 qV0gCECKNm2PuyWr7KUoQdQXbHpKCIkib+8i9upELwKgdWDCr5cy6OHbUZ1bVcxSzOqJ
 cdcPWdCDjX8T7WnjR/OQieCxNWOdPPn8lW0V2rfdrX1uJByHnv8Z/5SG6Bkn1mJq0cDl
 8S7I/ZnzHqlb4zZl6cfhUFE2sNquTVdmweTj3ex89fIYGEWn0sDf5eMfKUFhBkoXVcyE
 7MinHT4UI4DUpgYAtW/bIXvNnlQkuOT3mIXyZgbrCgU5pYMiPzq4k4whRXyZyYJoCmpq
 GlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286340; x=1793891140;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hYnFjfVMRxMQyu1JvJ9tMZoEHvJhC2MVpyrJBN7CJhs=;
 b=BPlZc+FaFytl3q9zgbPc9L1jyAzIsrSiBehMrPZmocHgUb68RRUakI4y77p4JAebVJ
 jvx/QH0QnxZXAUPcYz5CXivRzzaTrJUQustbuQTEpDMFDHIdGBK/THd4SsQlcc5ew3LP
 T/zjNBm8XY1Zx76WPINTy1HMpp2UMs9USUDTJeuK3xhaZqdQg6nFLC8qIE4odiY+W81X
 WC6680tOoeq9F8MdxWqGCOrsAGZAdfTEx6bgfxFiPLYHHg53bpu2kl7wJdPMue5JPPHh
 hMYB6TAQZsxLvKeGRpxVehu+FnYKi9eRy/N2Mi62Xn2NRqaOCl2+OLKGz1y79R7V04Fj
 ESXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgVPVb5qgx98YXcxjkkk/w2/PQiWd/bORTa2YYRKieaGL5DddChZoFCOzTR8jqI2PtV/hbML6Jlvot@nongnu.org
X-Gm-Message-State: AFq9FYIZ0r92yGm+EQG9DVrpKMnH9OT/+c+M0JoOSDfr4iTE5xsiUqi/
 pdyJGZpV8GlOTcu2Be+JDo2t0R+y8NYZAE7Lj/CweBNjSxFxz39++pHJ+1BG/AtPtUGwwz+LEeJ
 rkyTP/SHxWFr8Wbzu0HPS5rv1ej8DHmDamr4F85NAGw==
X-Gm-Gg: AYBFou3NqHZN2wCLxGi/WqfXosFQsT2L6NVYOHGxlH5qP3x5N+dderAT83N1HzlxuNf
 9MDt4lOOoEQNw2UOvBG8CwmRqB8q2CiS6Qt3eM9mNqZWsSqZ+vRtVNDZm6iRiRMqmrqOHdoqn8U
 T17INJhDgPrMBMqQzWnLgF3Dou4qhpNEKWqGOHR0jREkJEnUZQfFJgTJKVirYSuF5DCzmI4Fgvv
 iIdwVaeajZYCYa9JQ9IYhWeSgZEf3IgTIAFbzHEVYEHhwI878kL1ThjFdcKLwjhMugh9wG3sbzo
 4qHHQm3hRFeUAUXuuX/JmFrAe3fY82p0hFNxoYy2cYW5pfYuvBvsfTwoK2phbbDxGT9UeyXTOhS
 n+dh96y/JQb36Ra+hWU5AP5N8Nb4PfZYvVTN/wL6gcpA71tcU9LbYpiVuZN3MtoIOT40cQEYy8W
 ve4xoBOHrxaw3EjKTvPYmk
X-Received: by 2002:a05:690e:190c:b0:679:b364:12c1 with SMTP id
 956f58d0204a3-67a7bcd6e3bmr4586733d50.83.1793286340284; Thu, 29 Oct 2026
 08:05:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-6-eric.auger@redhat.com>
 <CAFEAcA-v2s39f5n0b+9ZD4QHd5irxUwqzUfsYUb8x0GTqU_z4Q@mail.gmail.com>
 <48af9561-c3e3-4f8b-9301-f15bd7b317c6@redhat.com>
In-Reply-To: <48af9561-c3e3-4f8b-9301-f15bd7b317c6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 15:05:27 +0000
X-Gm-Features: AclHuK_ukuelrxbKyYDaUXT8RyagQRN1W8lvgbGq9G4udrGmswnujnc2tpHF6P4
Message-ID: <CAFEAcA-AJmH=anZmeu7GCZ8c1V7sbY6tBEFaJB0R2809tbpqxg@mail.gmail.com>
Subject: Re: [PATCH for-11.2 5/9] target/arm/kvm: Pass an error handle to
 kvm_arm_create_scratch_host_vcpu
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 14:55, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 10/29/26 3:37 PM, Peter Maydell wrote:
> > On Thu, 29 Oct 2026 at 09:23, Eric Auger <eric.auger@redhat.com> wrote:
> >> This allows to report a precise error message if any error occurs.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >
> >
> >> @@ -371,7 +377,8 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >>          features |= 1ULL << ARM_FEATURE_PMU;
> >>      }
> >>
> >> -    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
> >> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, &local_err)) {
> >> +        error_report_err(local_err);
> >>          return;
> >>      }
> > This isn't supposed to report an error here. The caller of
> > this function is kvm_arm_set_cpu_features_from_host(), which
> > sets cpu->host_cpu_probe_failed for any failures. That is
> But is there anything wrong output an error? Added errors are related to
> - Failed opening /dev/kvm
> - Failed creating the scratch VM
> - Failed creating the scratch VCPU
> - Failed getting the preferred target
> - Failed the init of the scratch vcpu
>
> all of those are practically tagged as errors, aren't they? So does it
> add any spurious msg for something that is supposed to be normal?

We call kvm_arm_set_cpu_features_from_host() from the
"host" cpu type's instance_init, which can happen during QOM
introspection (which does an init/deinit but not a realize).
instance_init isn't allowed to fail, which is why we defer
reporting the "this didn't work" to realize.

> > later checked by arm_cpu_realizefn(), which reports either
> > that you didn't use an accelerator type you should have or else
> > the rather vague "Failed to retrieve host CPU features".
> >
> > If you want to make that more specific, I think you need to save
> > that more specific error information instead of the plain
> > boolean host_cpu_probe_failed, so you have it in arm_cpu_realizefn
> > where you can report it up.
> Maybe I can store the error handle instead?

Yes, that would work; needs a little care about cleanup:
arm_cpu_finalizefn() needs to error_free() the error if and
only if we didn't propagate it to the caller of realize.

-- PMM

