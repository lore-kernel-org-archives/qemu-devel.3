Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734C7C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0u1-0002E8-Ii; Fri, 14 Mar 2025 05:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tt0u0-0002DQ-5K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tt0ty-0001Bl-CD
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741942812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=km01Keho4CU/c15cApRCkiKecIG1V9S+kpV55CQGZzo=;
 b=dEjxBa939AwezIbQw5Lr4DJBKKqweZp/sVMm9+RVqW7pI5scVKSOJnEAtIJc2QKrI9MAVo
 ifmcK3hzufTW5yxMgI2lbNINkadAZdI9yDVwooWAFIwJTQdl3AYiS3VA6zVHgGZ5QlJNSL
 wJFc2GFCohKPXp8W2bm0Q2XcgsXilE8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-2WPTWDh9MaeoPMUuCG67fw-1; Fri, 14 Mar 2025 05:00:10 -0400
X-MC-Unique: 2WPTWDh9MaeoPMUuCG67fw-1
X-Mimecast-MFC-AGG-ID: 2WPTWDh9MaeoPMUuCG67fw_1741942810
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912539665cso1379026f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 02:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741942809; x=1742547609;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=km01Keho4CU/c15cApRCkiKecIG1V9S+kpV55CQGZzo=;
 b=Kd6oIkVxd0psRPGq8KFNXuruHMKa38VaPXRbA11ubjQMp+ugdHYQpaWZgA0Oxp6OCD
 F/TDRPn/Pwl7QIQi+V5Vo80BCzBHr+6qL/GVra5FXXuZEGzzAFNsCtHI3Vre9h7u0T0X
 cJgcErFcrdJPcqjofM6p8h2prF4QOoE/h+d8wOIvUOFiaRAeAZHr0hkQt/ZDQTkyI2Md
 wxvlXaNBtDKq9mn8eZIVt6uWr2r3iNav2e8MfR537kkZ79iadBkwR/f4/fEzzcpbi6Zb
 3WQzT1bnTe5HotW06T+PkPJ37G/+Iqn+o9rYFyj/1/OZ6bu/Kd9WcNEe1yqyIUox8YPa
 UUTA==
X-Gm-Message-State: AOJu0Yz0+YVw3niqswH7xPsbT40T9zVDH2a82MrCvTACm+hu5IKbOuAB
 XKUSOAWJxl7zZtLfyKlruDXIroshbYZlIlBeeE9ZinvxEk3jY+nLjv8RJeOXENDnTswy2Ne3iv9
 Bkg0P4sExyytmB73F6FSBIN3r5BEiadwEfd7t0kqxtfJE8BGGvuVl
X-Gm-Gg: ASbGncvwW8WIn8VNme9M7YOaYiI+4u29WPM1/dXPcAu9pSZaMdsNOMWvTA0ozLZW1JU
 poSRZzm5Wuew3MUSBp1VuXat2HR9Drl2v4X7DR1W4AIMRVwGN3oyLA/6JvAwpW7jvltq8jjz7z6
 KP9NEbIPACeCdZicNg/HuZgh3X0k0PAYHKC230lEW58S56DDjK0M11dwEH4W1xAaH+zk+21Le7A
 qYZ4go6v41Gg97ivH+PF+xAIa74uIINor/cx97nomoYIhYEKaAVd8I7YK+4YSVh6IJQODISAeRJ
 F6EGAAxSjmYp/iGQCN0ShB6yc1UbZVIpm7Mc83ay4ZbihpgvpoND6SuqYvvu4KUsto09lGvndNF
 9sDs/x/+buEjIhZCQTHlw7qiX81HmwcYKmjdSLOFtRpg=
X-Received: by 2002:a05:6000:1562:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-395b70b7668mr5590083f8f.4.1741942809483; 
 Fri, 14 Mar 2025 02:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbPxxtzCoXupAbS9J3gXnk5ZNGFMOKrYYlL4CrwLNw2PaPr+PAxq1A9prTMNLmvuzbyMu4xw==
X-Received: by 2002:a05:6000:1562:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-395b70b7668mr5590032f8f.4.1741942808980; 
 Fri, 14 Mar 2025 02:00:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d?
 (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de.
 [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb953sm4910658f8f.93.2025.03.14.02.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 02:00:08 -0700 (PDT)
Message-ID: <11d40705-60d8-4ad6-8134-86b393bfae8f@redhat.com>
Date: Fri, 14 Mar 2025 10:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] memory: Attach MemoryAttributeManager to
 guest_memfd-backed RAMBlocks
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
 <20250310081837.13123-7-chenyi.qiang@intel.com>
 <8d9ff645-cfc2-4789-9c13-9275103fbd8c@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8d9ff645-cfc2-4789-9c13-9275103fbd8c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 14.03.25 09:21, Chenyi Qiang wrote:
> Hi David & Alexey,

Hi,

> 
> To keep the bitmap aligned, I add the undo operation for
> set_memory_attributes() and use the bitmap + replay callback to do
> set_memory_attributes(). Does this change make sense?

I assume you mean this hunk:

+    ret = memory_attribute_manager_state_change(MEMORY_ATTRIBUTE_MANAGER(mr->rdm),
+                                                offset, size, to_private);
+    if (ret) {
+        warn_report("Failed to notify the listener the state change of "
+                    "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                    start, size, to_private ? "private" : "shared");
+        args.to_private = !to_private;
+        if (to_private) {
+            ret = ram_discard_manager_replay_populated(mr->rdm, &section,
+                                                       kvm_set_memory_attributes_cb,
+                                                       &args);
+        } else {
+            ret = ram_discard_manager_replay_discarded(mr->rdm, &section,
+                                                       kvm_set_memory_attributes_cb,
+                                                       &args);
+        }
+        if (ret) {
+            goto out_unref;
+        }


Why is that undo necessary? The bitmap + listeners should be held in sync inside of
memory_attribute_manager_state_change(). Handling this in the caller looks wrong.

I thought the current implementation properly handles that internally? In which scenario is that not the case?

-- 
Cheers,

David / dhildenb


