Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903F0D69114
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfIu-0008MT-EP; Thu, 28 Nov 2024 09:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGfIa-00085L-1q
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGfIU-0006hm-DV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732803308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VejTOPK7ZWz7AQbmc2M0mMnEeSyYDmbtw1UPGuTLiQw=;
 b=Rl1VLeTSykxP80Sfqupl5BXV5tWb8G0CC1UbpFcY8OigO3fnWLwXjmoi0KOyAlM9LZpaVZ
 lKxJPjZJZimuTmXrlbT9ajZxYatG/HQDG+853lU/Ic8p27kDSGaPlyC7BfoSKvkcKp+xDK
 VgHVKYSvPNQxaji+J/YAw+nMVcDDVhk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-wjmtlJj5NKKcGrE6chYxeA-1; Thu, 28 Nov 2024 09:15:06 -0500
X-MC-Unique: wjmtlJj5NKKcGrE6chYxeA-1
X-Mimecast-MFC-AGG-ID: wjmtlJj5NKKcGrE6chYxeA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d412384987so36203306d6.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803306; x=1733408106;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VejTOPK7ZWz7AQbmc2M0mMnEeSyYDmbtw1UPGuTLiQw=;
 b=m1zvj+4DVA9e1EVNLaqLrAgGv+j7tfs+QyiHBDfNKSfFA3xBuh6+hmmCVRUy3TEoN6
 Al4sQP38LqVtEliotwwVa9p4Wp1wOAVjSCq3nH/IRyoXF8r8Lsf7I4tbBlSdlXbureOz
 ihCsoY/mFhPaIZX4ClSES/2ZjyOJg87SZH2gskJgUjyrPq43Pq5UKC9t9o2HHEw60HwH
 2Zfo9PDmCUFuqslDI5FbSngO3KGWG88TZqoADGzsUd+Bh7MOY+TMdOn9bJzYuoDWg2CI
 kFZNzls5ugYJWcowx31oTlaP29ARy5M/VrzDUGNq726EGWoCxlSpEGtbpTibZwEKsRd7
 5noQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2tRaYIegp1CsDvrnOBzkHcgu2oE9JZBviasTiFJp4Sb3wuUbOM/9hGHgB+XLaTHDxRSxAsD7vbnD0@nongnu.org
X-Gm-Message-State: AOJu0YyO15v3Q0y8GxLQg8i9CC0FZMb91npQkM3Tk2mRD2XKeBRIhpIU
 Mj4r0lmMc0enQHiZPiJbvshKB28DkR2zD4wlhXzfN8tYXzBZa41xmxXOuKLJ+VBuqHMAdMz3p5d
 bij4nP+98kBIzKKAmjFpmA67NXXRkPWeg3d+zQK47ZjN5NlaxJor4
X-Gm-Gg: ASbGncuZ0L0k12xsHlRxD7uaA7u0bq1yXzm47RHOJG4gaarExCp/gjyjMjFj4Jhh2T3
 ojCnYmajQNo0GVJ1xg/uZmZwgMPyKV12Mk8y1239J+OFP/FGOR53S0BqNtSIKp7rK470i1h+/Po
 KNVTBsjP+scIxHY1sb4+e7vKXiXLp/5K4ONp+pnjtYMwHQBrqlCTfK4wfvvAaabEQOS9OPOOmL/
 /CSUTUtYVbmhzRwbQzTozNqNxNnIeD+Ms9FtEeXuqx+OQVjWzpR4eLJuq+oFKZcd/sQfWOvvm5c
 Amnjyg==
X-Received: by 2002:ad4:5dea:0:b0:6d4:1432:44c1 with SMTP id
 6a1803df08f44-6d8729ccb6bmr46997866d6.22.1732803305977; 
 Thu, 28 Nov 2024 06:15:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9udl/gvjRsf3V/+eoB7mm0V79FigZ5F5okVUe8qFcwgwyfGfhqGZVCyTPxsMNR8OghDk53w==
X-Received: by 2002:ad4:5dea:0:b0:6d4:1432:44c1 with SMTP id
 6a1803df08f44-6d8729ccb6bmr46997256d6.22.1732803305517; 
 Thu, 28 Nov 2024 06:15:05 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751f741dsm6837576d6.74.2024.11.28.06.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 06:15:05 -0800 (PST)
Message-ID: <2cd85500-a563-4c98-ae97-0c0b73e463c3@redhat.com>
Date: Thu, 28 Nov 2024 15:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/14] s390x/cpumodel: add Concurrent-functions
 facility support
To: Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
 <20241112155420.42042-7-brueckner@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241112155420.42042-7-brueckner@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.932,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/11/2024 16.54, Hendrik Brueckner wrote:
> The Concurrent-functions facility introduces the new instruction
> Perform Functions with Concurrent Results (PFCR) with few subfunctions.
> 
> Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>   linux-headers/asm-s390/kvm.h        |  3 ++-
>   target/s390x/cpu_features.c         |  2 ++
>   target/s390x/cpu_features.h         |  1 +
>   target/s390x/cpu_features_def.h.inc |  8 ++++++++
>   target/s390x/cpu_models.c           |  5 +++++
>   target/s390x/gen-features.c         | 13 +++++++++++++
>   target/s390x/kvm/kvm.c              |  6 ++++++
>   7 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
> index 684c4e1205..ab5a6bce59 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -469,7 +469,8 @@ struct kvm_s390_vm_cpu_subfunc {
>   	__u8 kdsa[16];		/* with MSA9 */
>   	__u8 sortl[32];		/* with STFLE.150 */
>   	__u8 dfltcc[32];	/* with STFLE.151 */
> -	__u8 reserved[1728];
> +	__u8 pfcr[16];		/* with STFLE.201 */
> +	__u8 reserved[1712];
>   };

Please remove this hunk from this patch and add a separate patch in front of 
it instead that does a proper header sync of all linux-headers via the 
scripts/update-linux-headers.sh script instead.

  Thanks,
   Thomas


