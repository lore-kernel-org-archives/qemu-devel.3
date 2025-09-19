Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28397CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWV0-00076g-66; Fri, 19 Sep 2025 04:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzWUy-00074E-1a
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzWUv-0000i4-Rb
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758270580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HFLtOUP7N03UaSL5e3Et4I0WNFul5nYL+eIN4sotvqw=;
 b=NAg71Yy19gVenWWwxNjV/L5dBXRi89Pw59/ZDv9ztcN/yrQ/mcnROIOVTFyBOsHJY4xrea
 pl4bi5yTvqYW/NbGen2GfGW5Jdp4ZsUl4lu4dXs5PmhzaGQCe1AoUu3e0eDy8PbftLUW6H
 1qzqTZ93L8IUKRM9FDJKeVnINsSJNCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Cd9t8dSaNTGOWKbaHw4geA-1; Fri, 19 Sep 2025 04:29:38 -0400
X-MC-Unique: Cd9t8dSaNTGOWKbaHw4geA-1
X-Mimecast-MFC-AGG-ID: Cd9t8dSaNTGOWKbaHw4geA_1758270577
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee1365964cso1245503f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758270577; x=1758875377;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HFLtOUP7N03UaSL5e3Et4I0WNFul5nYL+eIN4sotvqw=;
 b=RAiB0c8ir6r8mnEzhmfy4aIbx562JqaO6P1JqbuPBpoUZw3IM0tPD6pRDnY6FVdHRm
 MCvTTzwn93OOIPwCwyTUdjSfukvedwDtAbgybOpc55LIjQnoam4/b0ndih/iD/iHjBPH
 xxHJW7oMQRMtbh1sx8GlfbIbI4UgboVjgC9DsnO5eTR2WzwrYDvLNJQXUEAvp8ahCLGl
 H6lZ5ASRDLD00uQ8kc59NU34a/DQol/zX7ylQ2CRdav9zz1yQedkLdf/+HQVonEA87eb
 bAzlAJAOUU4jvS9zYsec9smB1r5a+/PvpPNxKw/PZSldsX5rNSmd7FKbbaM4kStpEwyX
 HAZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYGckKv/qbEsvbpOJKjNzD4UjJwOnGWGXVZ/j6q3aUIGGWeRdyhlnAExcw0pMiZh2G3WzUx2D4HcTa@nongnu.org
X-Gm-Message-State: AOJu0Yze6H62x4z20+KvWDycZLabi8O6EiJNU6RxsvUNOWYegrehPvvP
 xy/uAWeZoGS2YspTETUzR/Z+cIe250Ua1PcUb1iDK3G5vrnb2e14Cr//Qb1BhDRibTv81hesurI
 jABDX5aYDvMD9J7va23ZLqa6Xe9+mHfSupG80GshzDZX4YLbo7CAsPref
X-Gm-Gg: ASbGnct5SlQNUcDKxdH/qm3O9e6fiuXPO558vhauckZ+wEt37mkOzOxhqarNdGr/1lI
 qa9s+JMZhx49DS5f2f7LoUn608Yd4C86cWI07Zqo5kJJ4wRQOyiRWZqWcxxovWdiVjB9cfRNwSj
 /pt0i4UujdY1+Dt0gvElO2QHnjat5grvvkslzjzlNSNrL+Sau5h0eFIx/vg4hCNPLwO8s/Tg4cX
 WmH9wrQtYjLjjgLBrekjazq7VxUsxcreMYiV7mSIBrRn+FQdCfpSwwIOqkAu28jHTaL5DZ47pO8
 5PyYSP3o5yvFgOQsWHX9/zQk27uGihm7uvmOnIQZIFFySN+ePxeC5AwcwH5JQHofVqcJ8tJJdn4
 X/1I=
X-Received: by 2002:a05:6000:1ac8:b0:3e8:b4cb:c3a0 with SMTP id
 ffacd0b85a97d-3ee7d6864f4mr1442182f8f.8.1758270577131; 
 Fri, 19 Sep 2025 01:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9znMgNaWnauAbCShrysR5ogAuDXNeWTkfKCIk5L9dlfzO5uopAjtuyVSTDJCPRTTzeWWJrQ==
X-Received: by 2002:a05:6000:1ac8:b0:3e8:b4cb:c3a0 with SMTP id
 ffacd0b85a97d-3ee7d6864f4mr1442174f8f.8.1758270576667; 
 Fri, 19 Sep 2025 01:29:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc72e6sm6544998f8f.29.2025.09.19.01.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:29:36 -0700 (PDT)
Message-ID: <4f83d92d-7742-4fc4-8a80-8a780f7e228c@redhat.com>
Date: Fri, 19 Sep 2025 10:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] tests/functional: Add test for IBM PPE42
 instructions
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-10-milesg@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250918182731.528944-10-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/25 20:27, Glenn Miles wrote:
> Adds a functional test for the IBM PPE42 instructions which
> downloads a test image from a public github repo and then
> loads and executes the image.
> (see https://github.com/milesg-github/ppe42-tests for details)
> 
> Test status is checked by periodically issuing 'info register'
> commands and checking the NIP value.  If the NIP is 0xFFF80200
> then the test successfully executed to completion.  If the
> machine stops before the test completes or if a 90 second
> timeout is reached, then the test is marked as having failed.
> 
> This test does not test any PowerPC instructions as it is
> expected that these instructions are well covered in other
> tests.  Only instructions that are unique to the IBM PPE42
> processor are tested.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>


Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


