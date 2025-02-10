Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCABC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 12:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thSvr-0001ks-Jl; Mon, 10 Feb 2025 07:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thSvh-0001js-Kv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thSvf-0005lw-0g
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 07:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739190620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/sw9FVlkfrLmKZL5R3fNcbgwjkVKowArYHC1ihy6MBU=;
 b=YL6huxBhMz4bPiEjhCDhNfjBiJl/zUQhxvUCIn6spQ7WQxTxhRSBI0qYu26fI5+sbumPUw
 EZxoVMcoH4mZNJQPcyL48qPbIgvQXpuNqiflYGTNqyp0FNW0yG3gG6r3YnL3yIY2MWl1WD
 SMIg1o+bieNdr709R1oe+yPDIDaQwqo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-q3b8ftl9Ok6J8STEYjBWFw-1; Mon, 10 Feb 2025 07:30:17 -0500
X-MC-Unique: q3b8ftl9Ok6J8STEYjBWFw-1
X-Mimecast-MFC-AGG-ID: q3b8ftl9Ok6J8STEYjBWFw
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab76f438dddso469592566b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 04:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739190616; x=1739795416;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/sw9FVlkfrLmKZL5R3fNcbgwjkVKowArYHC1ihy6MBU=;
 b=vfNGekVuXDcd+DWstDwZ7EFWUaupLGAt3ddW0ArEbUdVcM9rvSNa+O5WS5BUDR2aM1
 v9kmxG/mClCiiB+6ytbTRw4SAEfNQbTIObjOPtpKPZeLy+OxEWvH/4hZqcRnMSAwsuGW
 bRE9p6n7AQX9ug7RzYKqKp66A7VBVN6zoMKkAVKJvNjTZ+BluljT08OX7mCJG3G56F7I
 T63iJ2sHsODnOUaaRq52cunfsg8W39mWoxaslyjPY2Fl3p4+tGVpItJitdQ/ZHSJ/Q9y
 xDTa35VXMet7jjQLHPDB9M2cxLnJtkug1O8E4hx2qGs1mr4v7l0cjqgH0RRemRL2XtrU
 ORiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmwf07wUDTTfOaE4RlOwQKbT64cCJZcSnRGfzgKxJdl7YbC9ouFNVLsZA1nq8o4xxV+5pToqHiRV4m@nongnu.org
X-Gm-Message-State: AOJu0Yzw+9OU4A6CCyPC6XK0eZI3U7VQo7OCd7E1Evi0NXSngp+KIzj/
 4ZyTER1mm0A2r8fOHRK/KpVS2sqzcubrte40smqcNtvr7YlmicTxwvhdNQgu0pYtzmaKGfk/6GY
 wES39Qhr+Jx1rEa+8xj743VryQkYRC9L4MSMOn+87aaBLqYWTm1ET
X-Gm-Gg: ASbGncvR+Oas4NqvmE+IQ3Q2RwPK6ZeOfphtpQCP5dBL3KN1xpm2cMp5J8GHgd+9eJp
 BTWdtUoGsCk58TO76M5ikpCRT4Ofi/35B/vhozxqifrdHduvEYU5P6AFbrhd/XkO0J1hm8mPiUi
 QAwUAbtDPnZ6eCxrpq/wz7pw3MyhjYpndA4WOrK/kmUkuvja0rRBbZxFmLb/7yE2L4NjQlYNl+7
 wDvwEOkznbcGUdixUeFNdAWZpkYdDA+UrXgcvjJt5FSdeMH1AROgcO5nJVqPrvzn7PLSvXOe0k3
 vKC9eQ==
X-Received: by 2002:a17:907:74c:b0:ab7:844e:1bc7 with SMTP id
 a640c23a62f3a-ab789b25d60mr1350798266b.32.1739190615526; 
 Mon, 10 Feb 2025 04:30:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+R/lEt9yDaOwV1i8MD7FRHQazrlKXwdCiiRCiHKyArWOAK8xdOQsbbtp0IiVicIE1wLHEqw==
X-Received: by 2002:a17:907:74c:b0:ab7:844e:1bc7 with SMTP id
 a640c23a62f3a-ab789b25d60mr1350793966b.32.1739190614841; 
 Mon, 10 Feb 2025 04:30:14 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab7c264f1desm206851066b.146.2025.02.10.04.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 04:30:14 -0800 (PST)
Message-ID: <ef7d98d4-c0e7-4bb3-bf8c-e36c5cfe2e05@redhat.com>
Date: Mon, 10 Feb 2025 13:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] qom: Constify class_data
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/25 11:25, Philippe Mathieu-Daudé wrote:
> Following Richard's suggestion [*], make QOM class data *const*.
> 
> Note, rust code not modified...

Untested but it should be something like

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f36be2831eb..8603f7cc657 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -180,7 +180,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
  
  unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
      klass: *mut ObjectClass,
-    _data: *mut c_void,
+    _data: *const c_void,
  ) {
      let mut klass = NonNull::new(klass)
          .unwrap()
@@ -523,7 +523,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
      /// the effects of copying the contents of the parent's class struct
      /// to the descendants.
      const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *const c_void),
      > = None;
  
      const TYPE_INFO: TypeInfo = TypeInfo {
@@ -544,7 +544,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
          class_size: core::mem::size_of::<Self::Class>(),
          class_init: Some(rust_class_init::<Self>),
          class_base_init: Self::CLASS_BASE_INIT,
-        class_data: core::ptr::null_mut(),
+        class_data: core::ptr::null(),
          interfaces: core::ptr::null_mut(),
      };


to be split across patches 8-10.

Paolo


