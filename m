Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC4AC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqFa-0003JR-Iu; Tue, 27 May 2025 05:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJqFO-0003J8-Hi
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJqFH-0003dy-VY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748336712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avtNuWizimssGLsvXQTc/zqNpEmAnzHUinX40RmTmSU=;
 b=Sx4wuf5kUt41FCmjOKQS+v16MMpolzu15IK9XCPH7JcThqHV2ctSfZkotpDc1Bf8/7VuS2
 TXhc4Tnnvz0V0yemuF1O+iBEotAvFaucXKV/0l/AYW4DWbKmJaSBhim5HM8vd4iILous52
 Ivr6OCO38+VzlrK2IGGQ7NRXdmio7HE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-CIohKmMeMDWACVdIjBj9fw-1; Tue, 27 May 2025 05:05:10 -0400
X-MC-Unique: CIohKmMeMDWACVdIjBj9fw-1
X-Mimecast-MFC-AGG-ID: CIohKmMeMDWACVdIjBj9fw_1748336709
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4d95f197dso1092873f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 02:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336709; x=1748941509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avtNuWizimssGLsvXQTc/zqNpEmAnzHUinX40RmTmSU=;
 b=VVfNtup+h6nAlDq3CsWPb6sm7ZmI9TZsMXSQCp6xA+ukLesLe5qjsOVz5u3KbJetok
 0Di+9TbZwuCfagiyF9+doL1xooO1agCovA0k4LPxsoKAVy+Kc//gUtFUoP7X1doHkpzE
 qveu0IhYBHUjkZZmGm2yxTuuODk9Iz+1gAB4TU43Ps2I2hzeICIG5gZmHUOrAFVcOtu4
 ZG7D698CDv9ORXEU7HEKivO4mGfsROnzipFSM5p39LtnID+npBBAGV80iQq00mQl/5cf
 v/VZDXX5+/1bds24mgIXayC5WfHq3KVwzHGZ3q255CM87VS5/+LEJ67gFqGjrZGKodG0
 gF2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURO9NhBH42aJJ//+NuEXdBVushIT6FnTywOJSTD63zxybO48nMQEtF4YMrq+h5l5mdukrTLYP8+gh5@nongnu.org
X-Gm-Message-State: AOJu0Yy5XRx48qC7tHwMa9ABSelR2FtH2o4O1LkXleGCJJDwKhTCRnCy
 xi6OEC+UcV7NQs1fCoc8O7QNKu2bjPwjUB6ekHLzFloo09KSaESptZTovxfvKFWvO2X5bXGdVZP
 WMdU0GQBeFEwXE1+eT9j9jJxIHv1R+gS4uBBoXi+YSyyd398UwiqWtcqO
X-Gm-Gg: ASbGnctuHujIyRAoUaXXjarDoR3u4FRUp/KUFjAsXvRzD0PZtp6GagIsnaTMT1D1j6v
 ap9q8GAPBVCP8Y/gbgmoMb0M0+xFnqMNoijqeGiQkteNEEbfWiB8W6Sya/4EqwyzGaRPIoxkYXA
 /NGOL/Nh4xP7PEP3Lk0wORZMDseS3CCmNk4sgr55Ldk6dDAOHNnsVkZ0HQeXzcBQEEU7yKOt3vD
 +s5RKhG3nKrmIKnsUftFbTzp0KAHuhvYLd5EHtA9F3eYjAj7S+bDc4y3yJF+wYh2ExgsYI2sbol
 0T4aP6wYACgIlCy1whQSqEx2x9in69nRedgpl7XRECXgWroN8+XzmL/0wU0=
X-Received: by 2002:a05:6000:178b:b0:3a4:dfaa:df8f with SMTP id
 ffacd0b85a97d-3a4dfaae1e8mr2437505f8f.16.1748336709296; 
 Tue, 27 May 2025 02:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ+vZD+5JZx7z0Zwn0Oo8ReviFX82MSj7REOeoP4dyws6Nl+QPagOa0S+5ptH6K2NKUcnEgQ==
X-Received: by 2002:a05:6000:178b:b0:3a4:dfaa:df8f with SMTP id
 ffacd0b85a97d-3a4dfaae1e8mr2437465f8f.16.1748336708921; 
 Tue, 27 May 2025 02:05:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d74843b2sm6217927f8f.53.2025.05.27.02.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 02:05:07 -0700 (PDT)
Message-ID: <e3863726-6662-417e-ab7d-005c5ff9af69@redhat.com>
Date: Tue, 27 May 2025 11:05:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <86msayec3a.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Marc,

On 5/27/25 9:39 AM, Marc Zyngier wrote:
> Hi Eric,
>
> On Tue, 27 May 2025 07:24:32 +0100,
> Eric Auger <eric.auger@redhat.com> wrote:
>> Now that ARM nested virt has landed in kvm/next, let's turn the series
>> into a PATCH series. The linux header update was made against kvm/next.
>>
>> For gaining virt functionality in KVM accelerated L1, The host needs to
>> be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
>> with: -machine virt,virtualization=on.
> Thanks for respinning this series.
>
> Do you have any plan to support the non-VHE version of the NV support
> (as advertised by KVM_CAP_ARM_EL2_E2H0)? It would allow running lesser
> hypervisors (such as *cough* Xen *cough*), which completely rely on
> HCR_EL2.E2H being 0?

yes I can definitively extend the series to support
KVM_ARM_VCPU_HAS_EL2_E2H0.

Eric


>
>
> Thanks,
>
> 	M.
>


