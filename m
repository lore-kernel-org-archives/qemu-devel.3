Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CB60A2605
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XScfFg13;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HWORd5nS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTzYQ-0007vA-9B; Thu, 19 Nov 2026 05:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1xTzYN-0007us-UB
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 05:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1xTzYM-00046z-8W
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 05:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795084779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ciJjGGlc0D5CjZXzhIDMnU+zWdiCvACaIPGXPedi84=;
 b=XScfFg13lMWwT8Viio0EAylqkQTvqB17w8Fdv/06+XU3dFGyo4b1j6O9+5eO2gC8Moroyk
 D+JS1I9STQQmMyxfekNdMu7IeZmNe83Ah6k1duG5bgT05XzxOBbBfjXHrLjqdDtn211w7A
 R1FqrEsdvdya6WFWaqP62UitsHp6azs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-iRKbIICMMAGCF2w8Pm_eGQ-1; Thu, 19 Nov 2026 05:38:33 -0500
X-MC-Unique: iRKbIICMMAGCF2w8Pm_eGQ-1
X-Mimecast-MFC-AGG-ID: iRKbIICMMAGCF2w8Pm_eGQ_1795084712
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4aa0500c979so225176f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795084712; x=1795689512; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ciJjGGlc0D5CjZXzhIDMnU+zWdiCvACaIPGXPedi84=;
 b=HWORd5nSERr50FqVMDWJXH2O7zdJIDBEOMdyblvMEv9fWOsaL8fdh/Ad8au9g2ii/X
 Ncbrp7lKy/CUDb0GY1IKEi/ySgSZ157vsc1jPQPLUAKp7aW1WhoKbRKXytp84iYLf4oj
 kczK8izuE3GIPh7o6M6lNfvv3mlKg5iurhwnUgR2ANHvhGYRuWsZkDWkBppD5FVJ/Ffn
 i/bunivtlchWAq8xJz/zQ3/lF9pHdgzzOvJv75/do6yMNwg/iWWxR4kIdGrEUQFBQJFt
 4VQcAw4566jhOrtnTPpbXPJQf4y2epBjkdtjWfBVFXl9Y+vdfAc1ARb27PY9PekOfW7H
 pKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795084712; x=1795689512;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ciJjGGlc0D5CjZXzhIDMnU+zWdiCvACaIPGXPedi84=;
 b=GGdIKpx5a5nr1DAZ9U1PeMnHoUjyQufORCdQZ1SVsCQoqOCmThfosiVmYdISV/M2gL
 I92udBifouPWt2R0in1B3mDj6YgtD5BBTcfCf/odiDDoc3OUG/8iX8gWDyG+RxsjF/du
 UN0WmmeTu7peAiHoaF93MNMjnYqsOEqOhizIdKsQjY3RxqvWfhhT0lq3hc0c4ibsINBs
 EUqMRYh/meLCkfC+cBomPEpHBL5EytuEjhXt6AcDBKPJPAHbs48GldF2538f3A/cmGMK
 7To8AzyGZCC7ENmrelriC8wGYBq/O6klb7NRJB1xxqPUfbBbyECZha9+PksThnAOy7Ld
 5u9w==
X-Forwarded-Encrypted: i=1;
 AL+hErF1rl+sg2uFHXVroo2Rsr7Uwz5bSm3thus+j7rrzuL+FHq3XLdYXmwBgmFABj1vsXeMtO+jmsGS7VEV@nongnu.org
X-Gm-Message-State: APuU4Z90bEBaTpV8Id/zlno8WqBJWDpuA7GjiPxOqGOE3kJ95YJMnY8Z
 3J2fpWVALa9P9seGWiknQNsyxJXtgLacq7JeElVaSvLSkQvJCgmZKbgAwDzrq1XhlbEs4DB9LJL
 jZ+uaVKKRXeNPBjtuXhIq9tie/vWwT3HoPFFXCaA6AcbHgxiqVU8xCO0C
X-Gm-Gg: AZFdTZfzXri1ojzIzO03fXqHapX/aiBpDBs1B+ZLBSS9RB2iVqRXB1llv8Jisx7mdkE
 lEq3zDS8J8XeNbxelZBjDyIxm98PNtKB1k7vcMRomqnpUOkwlPEcX6lNC2K/w1VN7W/QZhnYw2z
 P3Rb91cBpCcFyCgj2v8tq2/XXa7IcBEu4d+0Yg996qrA/12Oo1uyQLBf/8DMFlV8BUzmjsnPcOs
 8NjJxEn7K05cT0YwH9/idi7YCKAq2YqnNknsj9RtRckdns86M4pyJwF1tqdbg9iWgl72eHEewOc
 sPnqypHAodZU8LH/Mq2lxKFAnUm1z7k9tJXGBIZ/Nlg1VJVLH4rOG0VtseWsC4Egiv8y+BYQPPA
 lWoY0P9smY6lwvz5zGOsxHF7EpRJF21YOkPmdhtEV9eFjGZos
X-Received: by 2002:a05:6000:220f:b0:49f:800e:aefc with SMTP id
 ffacd0b85a97d-4a639475777mr12857067f8f.14.1795084712504; 
 Thu, 19 Nov 2026 02:38:32 -0800 (PST)
X-Received: by 2002:a05:6000:220f:b0:49f:800e:aefc with SMTP id
 ffacd0b85a97d-4a639475777mr12857024f8f.14.1795084712154; 
 Thu, 19 Nov 2026 02:38:32 -0800 (PST)
Received: from [10.43.3.180] ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654b807fesm8883564f8f.10.2026.11.19.02.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 02:38:31 -0800 (PST)
Message-ID: <66383708-4218-48d2-a634-3c4c3e21174e@redhat.com>
Date: Thu, 19 Nov 2026 11:38:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why device-list-properties?
To: Markus Armbruster <armbru@pond.sub.org>, qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <87a4n5ch94.fsf@pond.sub.org>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <87a4n5ch94.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 10:17, Markus Armbruster wrote:
> As far as I can tell, device-list-properties can do nothing you can't do
> with qom-list-properties.
> 
> Both take a QOM type name.
> 
> device-list-properties rejects types that aren't concrete subtypes of
> "device".
> 
> device-list-properties filters out properties named "type", "realized",
> "hotpluggable", "hotplugged", and "parent_bus".  These are precisely the
> properties every device inherits from "device".
> 
> Why is that useful?

I think it's only by inertia (from libvirt's POV). I mean,
device-list-properties was introduced to libvirt in 2012
(v1.0.0-rc1~216) and qom-list-properties in 2018 (v4.4.0-rc1~209). Are
you looking at obsoleting the former? If so, libvirt should adapt.

Michal


