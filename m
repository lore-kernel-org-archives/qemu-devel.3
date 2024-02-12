Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B856C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 07:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRBz-0005yR-Gg; Mon, 12 Feb 2024 02:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rZRBx-0005yD-VV
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 02:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rZRBw-00069W-AK
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 02:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707724646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yCKwXZIjUdvbZBTZSR2lAf9PAw94CWcVys3ICO6O+NM=;
 b=ZCYPcKa+Wpca/7f+FqSAPrE2FgZkSodzfMZZzqmAV6wcsI8kqGB8gSTXTPsauf70xLQX/j
 wi3VUktWmqwwmxowOkD4IRAoFT6f47jdZvnlEd4sISPKwJ+xHdjWO0s87Gv84IccBfSgll
 48REQ8F84/JEDeyts1siY4m6IamvP5c=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-wJ0TvSsIP3Kt8Dx6GyxdNA-1; Mon, 12 Feb 2024 02:57:24 -0500
X-MC-Unique: wJ0TvSsIP3Kt8Dx6GyxdNA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6e0d348947cso1040508b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Feb 2024 23:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707724643; x=1708329443;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCKwXZIjUdvbZBTZSR2lAf9PAw94CWcVys3ICO6O+NM=;
 b=uJza9tcdb8lpSXaUiMZTn8WCWFvwUfq5/ZvCPhoKGmqOk1xAGVd5UPnqQjYMjf8mb8
 svCsFIWLQTbRN8J8rop/PcklWyx34Fa2OheP2VrW+xadHmMpjqygDdjZ0N+OlgTy3fEm
 VPhYXlMEeYMVopS0/iKGmeE8YFOGWdP1pAMJrXkqB5P/TP1U7KQmdWblI3BnQUub5G0s
 8mUN7AptkvNAqoacIF0WYLu+zATlmASIbdoVhTEVXvwYLcbuLBiMNmodaZc7TiuPbE5p
 1rM0jXpDt+BRAmdtRpGmdgmHB7L10PbJ99V7JGpLYNti/gbremn6/JZaOzLq2BmkoZwB
 6tVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ISSDqvYVk52CySIVnbzLLH112Aex/azHMyhlRqHEU1L7jDEDzq9QD4r8LlgsxtCiaVObSdtbEUzlNWKAFYPVViKnbZk=
X-Gm-Message-State: AOJu0YzEZ6TiSXS0ZkGsE/uWKiaihPRNTYodS0QhTrUK2rysUgG+kwAK
 R+MQ1gA9N3+i3YRT3EZhOK/Eka4MmDCc3y6Q0MFtGajoD0QymzpsF7Gt+/aqlGL1ld+nfs/kP6Y
 cKB1AdqWZP4eqxyr/xVNrFPx6ZoNVAEFYSpeg71FPv8hrUIIqA9PK
X-Received: by 2002:a05:6a21:2d8f:b0:19e:cce1:ed7d with SMTP id
 ty15-20020a056a212d8f00b0019ecce1ed7dmr4068710pzb.32.1707724643279; 
 Sun, 11 Feb 2024 23:57:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWoVl3isjxVMISW2p/bBw0RetyvYm6uuW5So/2gkZDQ5GxJuq7lPwvU1hzQhf8YJVsLdDrnQ==
X-Received: by 2002:a05:6a21:2d8f:b0:19e:cce1:ed7d with SMTP id
 ty15-20020a056a212d8f00b0019ecce1ed7dmr4068700pzb.32.1707724642959; 
 Sun, 11 Feb 2024 23:57:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU6IbwClkE4xTqNcRkAlcPnx8Xwk6spNryEkMYtXgdWzURnA0mjAPEcACiQI82z548RtmWxkd1lNIJL13d4oTe1mrCV75W+6spdzOWVuXNZcWM6Kh1IEPKAmjOqTvrWcktfM/DgQekrgMytQqoo+s2J5SBEH/c9WFEEqWfxFGxlDZxUW5FkRJTux9f8WG+kYOlR+MX0RFKoExg8Xb7jwL/471AxGeAfliFK5+aXHAweFus3rxuVCKXcv3oSJsyVVPWa5WDzpB2C6Hhf6MoPcYgHiWxCkp7ds2klmsyXz0QX6mk=
Received: from smtpclient.apple ([115.96.153.35])
 by smtp.gmail.com with ESMTPSA id
 y189-20020a62cec6000000b006e0d1e6036bsm2354285pfg.129.2024.02.11.23.57.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 11 Feb 2024 23:57:22 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ulrgo3dqewvffg3okryrsnnwhsdbb4f7sga3agmszfyv4jte7t@fds5d2ww4xyf>
Date: Mon, 12 Feb 2024 13:27:06 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25B8D5FA-5DE5-4174-8816-4A1E0C28802D@redhat.com>
References: <20240131024906.3920-1-anisinha@redhat.com>
 <ulrgo3dqewvffg3okryrsnnwhsdbb4f7sga3agmszfyv4jte7t@fds5d2ww4xyf>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 31-Jan-2024, at 17:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Wed, Jan 31, 2024 at 08:19:06AM +0530, Ani Sinha wrote:
>=20
>> This error exists only with edk2. Seabios currently can boot a linux =
guest
>> fine with 4096 vcpus. Since the lowest common denominator for a =
working VM for
>> both edk2 and seabios is 1856 vcpus, bump up the value max_cpus to =
1856 for q35
>> machines versions 9 and newer. Q35 machines versions 8.2 and older =
continue
>> to support 1024 maximum vcpus as before for compatibility reasons.
>=20
> There is a high chance this limit will be gone soon.
>=20
> =
https://github.com/kraxel/edk2/commit/7a03c17f0f4f4a9003d77db2660c8e087604=
b2f0
>=20
> If 4096 works fine with seabios, I'd suggest to go with 4096 as limit.

Any updates on this? Looking at =
https://issues.redhat.com/browse/RHEL-22202 , seems there is still some =
outstanding issues?=


