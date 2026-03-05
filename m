Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BDAF30925
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy53Z-0005w7-Pf; Thu, 05 Mar 2026 04:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vy53L-0005qL-3f
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vy53G-0003Np-VI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772703085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jQmiilIG/sH04DDYGF9g4OqjeWOUc0VaNSuShLd318=;
 b=hwjg+BJWnVNFAwQUD4lswHxHYz3v6P5cEv4D1uRJOwOiB9sVZMa9wRU6sV2brHHbLcX/1u
 rem+2+4xO+YwJPSIR3cTglu/z9sY13eY87VAPDZ/TvcWBN9Gr7aMnqT+rOMpPIoBHclAbT
 yZWGjwQ7xobI0Gz/g+VEf7ig4Dm7Ecc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-6a-Eu6LjP3uU2kPtmyUeQw-1; Thu, 05 Mar 2026 04:31:21 -0500
X-MC-Unique: 6a-Eu6LjP3uU2kPtmyUeQw-1
X-Mimecast-MFC-AGG-ID: 6a-Eu6LjP3uU2kPtmyUeQw_1772703080
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so59306325e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772703080; x=1773307880; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/jQmiilIG/sH04DDYGF9g4OqjeWOUc0VaNSuShLd318=;
 b=Xg/TdXXHvGATzBx3eiBLylczPg8vo5cTRqM648/LiN0fuLlb0dggD6O9IxlgpsDVBc
 4gO0op3l1qF0omRAI2uXETGAHC7fVYWgBcp9QkhEcxakpnTBniVv1MyQmpoISwF635ce
 vXS4MW7Atui1g6EXfrWR0/3adQeM6SiGKOI5/vyj1x221nLJKjyYisIYbuaRAlwTg5ur
 yMTK03i3HesmD1WpZxMGCKA6aVt74bNFTSFmOXQPlvNV6Mdgi7P98Sn3d7Jm14+O2SSt
 hqUhq6RBG2kuRTzv3JGO1kKbTGIiu9ByKU1JS1e1vLrEWhY3lL3h/SGVsfIKI14MkZ+Y
 baPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772703080; x=1773307880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jQmiilIG/sH04DDYGF9g4OqjeWOUc0VaNSuShLd318=;
 b=UQoToBxmiGvi+a9Aq3MnTgvc73J9rkD0xWoied3sDt1DmqD0qMd4qoojttyHis7l8p
 j8IZVocB8WZ6SlUPhDXlNBIRDZLcdd0bU5NpaUF8bWyLzxnS2dYvAemSvQDiGiKFJIf5
 kYxURUgPdfEoqOt0s8CntgxEjz8lDdUUcj+5dD81OusEDu5XnmhX4qxvvsvUaddh1hPQ
 HDkzU2aMIICq5CZHlFXFv1FBGxxfMoP9CdCQYLia/Cypmd4l6nnNfRP7hxRn3d8GKAAU
 /9bwMJTZPRF+WfgEqnlGSRsuHCV67346x/ly/csfmBQc+R0KUFpqiPCXwfFYy1WMmzR4
 ql4Q==
X-Gm-Message-State: AOJu0YxZfIV1MzuKd6qFw5MCWwezsuFAPac1EDRpJ5niaUijTlssB7or
 Hb+xnfgjgaUzcFFrW1a5TAsYbTG165KAXe5Unm41G+r8sEomHYPMoTZAkzN/tjL8FRkzdxWk7lx
 lyEvlE+KXmeyF+ixAVWJKJN8Pi4vtHLn36HXo9mg06B0/8urIOZ0VQdxr
X-Gm-Gg: ATEYQzxa/K3+zA9plNC3h0B8fvWxE0nFL7eKyvVPvjGeZA7xDDVsufuOtK1jTm+NI9C
 zMLSZXx2of22t0WVZVVYYR3B9hcvSPyQnjud1LltIM7Svh0OKOt3riuEO7Ydo+6ewzrPyML0L9y
 fOSwXO0BX3IR/5Hj0mFHC8lx0GqgkdQcqIjldWJmgXH6ODgE71fWWgtwBtd2oVYu12x3bo/2Bj2
 GGGAR/lseeAx9/dvlykLX1I4AMlrNuSe/SHE3N6O2L1NEcsg10XcXCMJnUH+mobH2UCfu4F8uD7
 a0NE4XUybp4kAAtfvOmagv0NLt5VtqOG4zeT2mdlM8B1on/12Ws1HH5NMiurpZOMgILOPDYIwtG
 CbGvP3g31GaYM1A2cmwi0R374neE=
X-Received: by 2002:a05:600c:470f:b0:483:78c7:e1c1 with SMTP id
 5b1f17b1804b1-48519840afamr78751935e9.12.1772703080358; 
 Thu, 05 Mar 2026 01:31:20 -0800 (PST)
X-Received: by 2002:a05:600c:470f:b0:483:78c7:e1c1 with SMTP id
 5b1f17b1804b1-48519840afamr78751425e9.12.1772703079926; 
 Thu, 05 Mar 2026 01:31:19 -0800 (PST)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm30202185e9.0.2026.03.05.01.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 01:31:19 -0800 (PST)
Date: Thu, 5 Mar 2026 10:31:16 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 osteffen@redhat.com
Subject: Re: [PATCH] igvm: fix build when igvm is not installed in a well
 known path
Message-ID: <aalNKlW7mwKINZR8@leonardi-redhat>
References: <20260305-master-v1-1-6574442f5ee8@redhat.com>
 <aalHT74pe1GtNzsk@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aalHT74pe1GtNzsk@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 05, 2026 at 10:08:30AM +0100, Stefano Garzarella wrote:
>On Thu, Mar 05, 2026 at 10:02:11AM +0100, Luigi Leonardi wrote:
>>`stubs/igvm.c` includes `igvm-internal.h`, that in turn includes the igvm library.
>>This is required just for the QIgvm declaration and creates an
>>unnecessary dependency on the library.
>>
>>Since igvm is not listed as a dependency of stubs, this results in build
>>failing when the library is not installed in a "well known" path of the
>>system.
>>
>>Add a forward declaration for QIgvm and move the definition of
>>`qigvm_directive_madt` to `igvm.h` so that we can drop `igvm-internal.h` from
>>`stubs/igvm.c`.
>>
>>Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
>>
>
>Usually we put all the tags back to back without extra new lines.

I'll make the change, thanks

>
>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>include/qemu/typedefs.h        | 1 +
>>include/system/igvm-internal.h | 5 -----
>>include/system/igvm.h          | 5 +++++
>>stubs/igvm.c                   | 1 -
>>4 files changed, 6 insertions(+), 6 deletions(-)
>>
>>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>index 416a8c9acead659786f22dfa7542f7af93699cec..cbe6f7f4c7c1092017296cbba09cc79b03b45b79 100644
>>--- a/include/qemu/typedefs.h
>>+++ b/include/qemu/typedefs.h
>>@@ -102,6 +102,7 @@ typedef struct QEMUSGList QEMUSGList;
>>typedef struct QemuSpin QemuSpin;
>>typedef struct QEMUTimer QEMUTimer;
>>typedef struct QEMUTimerListGroup QEMUTimerListGroup;
>>+typedef struct QIgvm QIgvm;
>
>So, should we remove the same typdef in include/system/igvm-internal.h 
>like we already do for `struct IgvmCfg` where the typedef is only 
>here.

Very good catch! Will do, thanks!

Luigi


