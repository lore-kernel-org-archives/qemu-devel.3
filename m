Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9814FCCF2C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 20:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqyO-0000TR-Hz; Mon, 05 Jan 2026 15:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vcqyE-0000R2-Ck
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:14:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vcqyD-0005bY-08
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:14:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso1692395e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767644067; x=1768248867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gDcGHtQkiMc9rkWNeSa+DSq9ZyhUx1y/T1vk3bYtESw=;
 b=lConEUB2MEI5XEDqMjYXnUFRVgsr/72fCxUchd8zEZVbn0HpTy5uTOywA0TSZjlX70
 UxSWvyuxzamkTnk5iVyIH/pwL2HowGVfS7fZCD1g8JDjrr7+Sju0gsNjjiFZw71lXD/g
 QMFHsFqsvnYEc8MoeYIU4IPHCIA66XMChiRWesxZF0GYpdI7KJGshJDk9M7bg8XyCgQa
 z6ehbJv3tQ4q17J8hxS6X/t1pLuhsRsh2LeFR697VJbCZZg2QlhbQZCKoj/nlspHn/Tz
 gpjTAULN1MwcHe8i7z1nLtlO4ngsgqZpCvsvk+zrExB6IH7JaeUDH2kBZYANlenq2eE9
 +cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767644067; x=1768248867;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDcGHtQkiMc9rkWNeSa+DSq9ZyhUx1y/T1vk3bYtESw=;
 b=YyYiyd1u3esoD1uS+bIdpEjiqpblQkGngu8JfxXy0xbPpWrEpbLV1gV5gmuqnh7tqJ
 l+OfB/j6lgfXH4OMZVSXmPwx2wugpACwLT999fW70Fva5MhV5x5Br+wkd7eSjDiiBNX4
 YQiHBR/2eclAnV1WaibALeu8Uju3rwjo62icnBtigxV85APgHn6ZzMnkQXAndxi72KZZ
 zcB/ZyW/Nm+bNjb84BcoMmKi6dxvSOgvnNmXjRGlaXuUoHwMe2JzfeNLqTac/4kZxhrM
 nfJP4pXp5SzEs9cvWXT9s59M3ZDBcxWYgp/6nqwGTvOt2iWVfQD2C0ee2vaxg6zwznpj
 exhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW59vzR7L8SceI4qe+BoFHTJRRN2crrWrWGKL8Qou8H81nfWkRfSSsH+t7gGkXnPbhgLTzYZeYZSeZD@nongnu.org
X-Gm-Message-State: AOJu0YyexUTO+5sVYR3O/3sJNNIKoNZb/BWMTqrath0jwGzZriwL8V2R
 rwZXRYnsJmOjgj+aR3X0zMGvfg1ryT1BQfNHhKBUz31cCm44Ormzq/YuTXz7RrYMXeU=
X-Gm-Gg: AY/fxX7OeJGs2REsXEQHo+N7uV1d3FRuasFZrUxa35kwzzovE7qO1R/l7v+JpmXnQrc
 TY+0tlrOHLXIzBBTB3X6UchIWLvCd1NoVTk6O5CzeZ3GMC6rFJsidCB4Mm9Oot7BxnwwuPTZAHD
 DN2G2z8Y45x+AL3qigpItI18CYR+QUpCJbjUCjLjhiD0bZyiIKpcVCp2McOuanvpgCOaP6IG7S8
 ah0UJY0v8WguBQ0rvEskx+St5A4cgf9+s0YKh408PPHdqK2lw/f4VYdfXD/2M3WjkBXOs1R/3Iq
 nywc5QXbfZF1FwVZ3Gqit0E4wk8n3+LRZzk/LXkgpSbAemreRvXcvEwoIz6o/QqdRR3JBbbO1kO
 eeIcf28rhf2YPtwK/0nw52rSwZoXDiqygt6L1zcqDNDGJE4Yd7PK2iI9G5g9BI5mjRgCA2kbaI/
 GNskHHmHVdwe4=
X-Google-Smtp-Source: AGHT+IFmvTeIABQ2ebspOjLUaJDFv9OEq/6AtBcLE0bq9KuhfQS94Ki5TKJGJzKZJNuwY3MT6ldUJA==
X-Received: by 2002:a05:600c:458e:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-47d7f09b893mr7699335e9.31.1767644066773; 
 Mon, 05 Jan 2026 12:14:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb4f7fasm786035e9.16.2026.01.05.12.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 12:14:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F9015F81E;
 Mon, 05 Jan 2026 20:14:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Max Chou <max.chou@sifive.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Communit call 6/1/2026 call for agenda items
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Mon, 05 Jan 2026 20:14:24 +0000
Message-ID: <87wm1vhl5r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Hi,

Happy New Year everyone!

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
06/01/2026 13:00 UTC

Are there any agenda items for the sync-up?
=20=20=20=20=20=20=20=20
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

