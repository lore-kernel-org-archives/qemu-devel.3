Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC3606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=t8OIoPY4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbV-0006k1-NB; Fri, 23 Oct 2026 07:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MUfbagoKCoo67o1zsCxv8u22uzs.q204s08-rs9sz121u18.25u@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbT-0006jd-2X
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:31 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MUfbagoKCoo67o1zsCxv8u22uzs.q204s08-rs9sz121u18.25u@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbR-00065h-5u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:30 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8a086f5d91aso1133858b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755506; x=1793360306; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FuBSe9OJwzfKrXcET3rvLFGX0WB83waI2spgmyz9HSQ=;
 b=t8OIoPY4EseRVpgsyoshBrTdIi0NDijidXhDRgLa93XX3i92iYwemiVBEy5S684D1A
 0M6PPcnqSl+7AN3E0FlD7mSFoYle8HO+0CP6HRK/Loj7J9iAuTOEzyHNe2daG0iLr4rb
 My5aTO5zdXjKezotWEftH10khxpH6eGOAtoozQ105stw0tWZfy/qVcsy59fh03BweYIM
 bspdlNVHSJS6zzLpPTvtwVvNNg2KvWS9a9w/W1o6AdpNBxce1DuZLGnP0ljZGXKHYJTk
 XVZE84VUFE5N3N43no7Qi6QcheKRxtzFkFKvF6iWrveVPnR0F/fz1sq3uQ/KCgZEIhw/
 RY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755506; x=1793360306;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FuBSe9OJwzfKrXcET3rvLFGX0WB83waI2spgmyz9HSQ=;
 b=UnuI8DPk23BGKHc8yi6Vygm2UZrhP+ktZWJyXJhKjBdxfjQAvS6oVzdJqx9ZOBRGKE
 D2heDg7WSK/YzB3iDOU7lHlY4P7K7Yayco12YE84CKRKxoeH6OGqx82/xvO3ig1a1sPl
 jkSuV7PT0tKyPKiXlmguM6N0JMf6i6tK/QoxuJxcC+HbzOwi99c2wyPMW8jmOfJVrbCs
 POlWuIVgrogYnayFR8lbn5JHRWpH/jXr8WIj7NYGeYkU36aAu4oAtFeesK/nTnLLfKuo
 jm38f7oS7NnLJhsp+BOyD1UX/Va60cCyK1gNCNbEfpdQSkCDExOmn4SuZtMW2MnHeYhd
 Xvhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYQwCNVbn3LL4zhX4yPykT24VU3aKrMHmapgjtwk8t1lzO9CywQwVAoR/WWZOD9DfZFvTpDIL5qf1G@nongnu.org
X-Gm-Message-State: AFq9FYI/kwzi53shhr0JrgOW1ZJ31IIulfwM1fNbUSYDrrpw0wMeQZWp
 kL9KECQ379IADYg5reTF+3ftswCtXwCTTqETMxjADnfw9peaXF5L99Fly25hGYJekEsl6RasQrS
 gIolzET8JNTd7MqwuV+Lp6A==
X-Received: from pfgs22.prod.google.com ([2002:a05:6a00:1796:b0:89e:78fd:6ab9])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9504:b0:89d:7f51:6492 with SMTP id
 d2e1a72fcca58-8a2c6f7f9demr1687503b3a.32.1792755505608; 
 Fri, 23 Oct 2026 04:38:25 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:23 +0800
In-Reply-To: <20261023080005epcms2p344c865eea89ea2129bd55804a36bef0c@epcms2p3>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
 <20261022074513.2292281-2-stanleyjhu@google.com>
 <20261023080005epcms2p344c865eea89ea2129bd55804a36bef0c@epcms2p3>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113823.3367624-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 1/8] hw/ufs: Add experimental fault injection
 properties for holding requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>,
 qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3MUfbagoKCoo67o1zsCxv8u22uzs.q204s08-rs9sz121u18.25u@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 17:00:05 +0900, Daejun Park wrote:
> Linux sd switches zoned LUs to 16-byte READ/WRITE
> (drivers/scsi/sd_zbc.c:607-609, "READ16/WRITE16/SYNC16 is mandatory
> for ZBC devices"). On a zoned LU from the series this one is based on,
> TAG_ANY therefore never holds anything. Could READ_16/WRITE_16 be
> matched as well, with the LBA from ldq_be_p(&cdb[2])?

Done.

> Task tags are 8 bits, but any value is accepted here.
> "-device ufs,x-fault-inject-tag=300" realizes, and after qom-set to
> 4096, qom-get returns 4096. Such a tag never matches a request. Could
> values above 255, other than UFS_FAULT_INJECT_TAG_NONE and
> UFS_FAULT_INJECT_TAG_ANY, be rejected here?

Done.

> Optional: the mode could be an enum property. A QEnumLookup with
> qdev_propinfo_get_enum/set_enum, as qdev_prop_spdm_trans does
> (backends/spdm-socket.c:255-262), replaces ufs_fault_inject_parse_mode(),
> ufs_fault_inject_realize(), the get/set/release handlers and the
> u->fault_inject_mode copy. I tried it on top of the whole series: 31
> insertions and 118 deletions over ufs.c, ufs.h, ufs-pci.c and
> ufs-sysbus.c. With .realized_set_allowed = true, qom-set still works
> after realize, an unknown name is rejected, and the UFS qtests pass
> 29/29. It needs hw/core/qdev-prop-internal.h, and
> trace_ufs_fault_inject_set_mode would need a small wrapper to stay.

Done.

Thanks,
Stanley

