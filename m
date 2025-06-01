Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075BBC5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZI-0002RX-2Z; Sun, 01 Jun 2025 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZG-0002MT-Bi
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZD-0004f0-Mw
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wf6Ybrgglog++IqUHvtdyMxVa/45A9n1FMD5TI8tZuk=;
 b=JRCiO6Of1s1+uUwWYU10x172e5AwdPW22Por+PrS4NzT8J4UjNXzWRrHk3uIQ0md86NkCR
 ctk5KZXZlKY1LtbXIYZGrgwgsQbJnNxJqWC12s6Ot7wReCExxNjsCsg5NP7QDDrVG5plAq
 3OXt1rvbapGLUTI3dGeT+FjkpPc8rdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-6xOEaojTPVi8OM6qikio5g-1; Sun, 01 Jun 2025 11:25:41 -0400
X-MC-Unique: 6xOEaojTPVi8OM6qikio5g-1
X-Mimecast-MFC-AGG-ID: 6xOEaojTPVi8OM6qikio5g_1748791541
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4517abcba41so6827775e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791540; x=1749396340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wf6Ybrgglog++IqUHvtdyMxVa/45A9n1FMD5TI8tZuk=;
 b=lqzEPigd9QB9AHgh1lshsvSNcM+pS0/HAzizopLqnR4k6Yda+l03NeScJ4cfcVPLlW
 Jc9XppVEWk34Qy+xqRS5FCP+0dBdQMOcqOQCVdg1vyM9U83R8QPuJHdsb2H1riHb2gII
 wKhl88bvvUq2X9OAgqvTfg1yb3DyOC2rT6J8eB7A+Cw7Jx2VZmjT5omshcFSNi7GS7d3
 EvOMH19C6vzLk52X0tdFasJduBgHAjgVIvQoVhvQHtwh3tgnymNjWPRehSPYWhs/YtXA
 L0ZT8uGsQfvu9heupg36SLAq1gk2HPB5SxhAEEhGFBGFyN0K1dMz55saiVx4lezFYnUa
 oAhg==
X-Gm-Message-State: AOJu0Yx0NN+Sl55/lAcX9QYeBQxRJ10AxLC25ZmQdvfpYEvtMAaLQhjD
 T3DL4AfoPKUT79Ha/+VVJzLKvDy5Ge4FxMmd78d65nQn6BaY38O63FEacFxIXX5JzRmqZALPsYm
 l5zjBGu6+cpGVnuJYFFa+uTgeaWL9BTUI913leJWhwpUXWGPb+juaffCmvFtJ1cqf/TmnbXRCU9
 nnAsP2agLWdFOIB3243Vbu+e3DEN6zOvqniQ==
X-Gm-Gg: ASbGncsHwY5lWYba/5vnQEWyla9qcILjfL2UpxbGUtwQ8JvmBqhwScx04qsodOqqTb/
 Ms0DTyVfQ4crHSk74l0TB8SXMF/lPLMq8eW9XaEoOmTofUw4kMhirPgpTB/Oo1Cj3XJEaiwLfKw
 EEWnZK9jDPi/4FhdYS3kHOjAMe84gozNTj4UUuTe1NfgPafN+qQH4aBFyTs//6jXiFQFdZWzI6a
 pPBrJZ8YZ2JQUjCai2QO2rP8W0LYO5+3RFgImj+vfn6EJHoN31Bf3hNU5zXi8s3OYBLf5CfUug9
 Q4x5vg==
X-Received: by 2002:a05:600c:a00a:b0:442:dc6f:2f11 with SMTP id
 5b1f17b1804b1-450d887db6dmr67019925e9.25.1748791539813; 
 Sun, 01 Jun 2025 08:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNEbgRAFsvpSjFzDv06aViamXn8Of5KAncRiHkwqoyUgr/OfXK414SvKksDMS+um3Qf2B2Tg==
X-Received: by 2002:a05:600c:a00a:b0:442:dc6f:2f11 with SMTP id
 5b1f17b1804b1-450d887db6dmr67019755e9.25.1748791539240; 
 Sun, 01 Jun 2025 08:25:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000f3esm88952865e9.23.2025.06.01.08.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:38 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 21/31] tests/acpi: Fill acpi table data for LoongArch
Message-ID: <28d0418c7f3d795a5f96be51d899b65f1c589256.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bibo Mao <maobibo@loongson.cn>

The acpi table data is filled for LoongArch virt machine with the
following command:
  tests/data/acpi/rebuild-expected-aml.sh

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250520130806.767181-1-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/loongarch64/virt/APIC          | Bin 0 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 0 -> 213 bytes
 tests/data/acpi/loongarch64/virt/DSDT          | Bin 0 -> 4641 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 0 -> 5862 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem  | Bin 0 -> 4647 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology | Bin 0 -> 5352 bytes
 tests/data/acpi/loongarch64/virt/FACP          | Bin 0 -> 268 bytes
 tests/data/acpi/loongarch64/virt/MCFG          | Bin 0 -> 60 bytes
 tests/data/acpi/loongarch64/virt/PPTT          | Bin 0 -> 76 bytes
 tests/data/acpi/loongarch64/virt/PPTT.topology | Bin 0 -> 296 bytes
 tests/data/acpi/loongarch64/virt/SLIT.numamem  | Bin 0 -> 48 bytes
 tests/data/acpi/loongarch64/virt/SPCR          | Bin 0 -> 80 bytes
 tests/data/acpi/loongarch64/virt/SRAT          | Bin 0 -> 104 bytes
 tests/data/acpi/loongarch64/virt/SRAT.memhp    | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.numamem  | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.topology | Bin 0 -> 216 bytes
 16 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology

diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3477789f422cad54f16734b3ec9ad1ff5135165d 100644
GIT binary patch
literal 108
zcmZ<^@N~{$U|?YU>g4b25v<@85#X$#prF9Wz`y`vgJ=){(SrOi9+)e_%gD^||35@t
fRG5*0;e$Si<G{ecaDah<K}-;&TmURD01^fOGLQ@b

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/APIC.topology b/tests/data/acpi/loongarch64/virt/APIC.topology
new file mode 100644
index 0000000000000000000000000000000000000000..e14bbf758464b146665bb0e46d193fe2b57b5db6
GIT binary patch
literal 213
zcmXwzu?@mN3`L&_kSa<}kksCQ6-cguibym}z?>|RJ=h@82cM-U``N$nIN$RE*n4{9
z+ta7loZa0G(5$XfPi?WH@<M8D2Z#t)fC$|KBJ===&?6v1Yd}cPja97c|B?P=@V!W`
Ozy}zTQr+*~X}tk+N(})3

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..f32e732b11a557ae01c7f383625d3b6f459ac9f7 100644
GIT binary patch
literal 4641
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..f19eae7d00f9c0eefc9e92de2c8a24863bf309d6
GIT binary patch
literal 5862
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..9b462869cd4911714e7c2a22025c465afa2a7d52
GIT binary patch
literal 4647
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
BB|QKD

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..8bbcd7dabc8b66f5e921807adca01bcc6a11c835
GIT binary patch
literal 5352
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..04d8d4c26fa2be24af40cd7a72959ec6b12790e5 100644
GIT binary patch
literal 268
zcmZ>BbPnKQWME+Ra`Jcf2v%^42yj+VP*7lGU|;~TK{QnXivR-y2Lpo~1D^oMTqmj;
RP9)%9V32{@4`Rzg*#Io}2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..5f93b05abe1669fe4239edbba8aaf4fe666f5b95 100644
GIT binary patch
literal 60
tcmeZuc5}C3U|?XJ<K*w`5v<@85#X$#prF9Wz`y`vgJ>k60A<&MXaFUp2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7a1258ecf123555b24462c98ccbb76b4ac1d0c2b 100644
GIT binary patch
literal 76
zcmWFt2nq3FU|?Wc;pFe^5v<@85#X$#prF9Wz`y`vgJ=d31_m&V3`7_hxEL51RFK2~
DqXGv3

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT.topology b/tests/data/acpi/loongarch64/virt/PPTT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..4017e2927c15c08c7e1a7e4d7eb10f416b63d69e
GIT binary patch
literal 296
zcmZ{dyA6Oa3`8IQjw%DVpkM@Q($EnJ3U;7nFa~1?WFW{w!p+%Fcjpl1xlJHl`_T`R
z^h@v}A_<_oDh@8S<L;yRuo~!o*xO;UmT7ha(wKL=EHg|;|9*WtkQ<-&DJu+%S=*<+
L11OCzvg%<cc6to~

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SLIT.numamem b/tests/data/acpi/loongarch64/virt/SLIT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..67f00813af7b2356fe74eed943ab8dcf2291578b
GIT binary patch
literal 48
ucmWIc@eDCwU|?W;;pFe^5v<@85#X$#prF9Wz`y`vgJ>oO2;dSG<pKcYv<CqI

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d 100644
GIT binary patch
literal 80
zcmXYnu@QhU48&w87=xe1Zs_olhIQE_o0v;L&Fk;fGOh%c$Im#L{LYXh1BQ>C2<z7O
O?>MkwuvS(5#pDG+#ti`g

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ff234ce45cbdd32f57fc0668aba135992e5ca887 100644
GIT binary patch
literal 104
zcmWFzatz5}U|?We=j89~5v<@85#X$#prF9Wz`y`vgJ=+j0|8V%qXt|C1~_00WPJc=
C#|Hrb

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.memhp b/tests/data/acpi/loongarch64/virt/SRAT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..525321890138de509ceaf9723f0a4565048e823f
GIT binary patch
literal 144
zcmWFzatxWkz`(%h<>c?|5v<@85#X$#prF9Wz`y`vgJ=+j0|8V%qXt|C1~_00WPM2L
PVDd1Uff=TOfq?-4Y8D3p

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.numamem b/tests/data/acpi/loongarch64/virt/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..2972a9abdcface5b943078d61b4946da80176ea2
GIT binary patch
literal 144
zcmWFzatxWkz`(#5?&R<65v<@85#X$#prF9Wz`y`vgJ=+j0|8V%qXt|C23TMWWPOYp
Ma2`w^Mx&?$0B=JF0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.topology b/tests/data/acpi/loongarch64/virt/SRAT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..75e0703ae0d3348919e2b583d1b4f4b8bb3ef65d
GIT binary patch
literal 216
zcmWFzatyh_z`($`+R5M9BUr&HBEVTeK|z6$fq?<U2GJl42Lc#;Ml^XQG(IyLp9PK2
XipFO{<Fh0488zT8fdLK}16dsa_U{M*

literal 0
HcmV?d00001

-- 
MST


