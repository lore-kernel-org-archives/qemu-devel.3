Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176C1C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aUV-0000v1-Um; Tue, 15 Sep 2026 17:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x6YzX-00018m-P4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:38:56 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x6YzV-0004WG-7N
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:38:55 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso66868b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1789501131; x=1790105931;
 darn=nongnu.org; 
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:message-id:date:thread-index
 :thread-topic:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2m9oaB+1AXJBYakKS7SrBn3h+gV73cFPAAh65MXqpJg=;
 b=hSbQpD6tl8CSjIaPOAgxDiFTdTRsd6v59K5n/Km0cNOofhAopTHAT3d1KVDyAs2m7j
 zRY10/Pel3eccCTMKMKMCpwpMXrxyGqj8x6Ud4XwFpf6+0psuBDImgKdK5cLw5ydFzhC
 iESD8R8o+qSNEnSp+TQQ5XM+OTfgtoQgc2bLQqlPDAbGdHzg2UOtM0mxya753jcyQoQY
 xYHjEtX0zksViu75HsJ+M35mIODTJBsFKAbczgCPdtdSHLgGJS+jWcIkB98vgBfyiXyB
 /Hd25/fT6k7+ZhVJJWqGs0V++5cnrSrdQRGJbMzFEkjCFnjIhG4C0uSnjPji1tyFQhKI
 4rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789501131; x=1790105931;
 h=mime-version:content-transfer-encoding:content-type:msip_labels
 :content-language:accept-language:message-id:date:thread-index
 :thread-topic:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2m9oaB+1AXJBYakKS7SrBn3h+gV73cFPAAh65MXqpJg=;
 b=t0GULl13diSXMu2I2TnE7yzlIFT9pS/M5mtGkgTwJ+bOs8oImwQ2uynHaooQsj/tNw
 h851VkocV5KocAOI0IYqRpWtJq/OzshTeRR0lFVSshgLr69CNqDlJFUGPdZNKU45XfzH
 kKiTcdREQK4z+El+8Hl8J0/Nxb2750bC3ex7itRaS6fqTSWDOqEhhlirlTf1+y4wiNS3
 /mzGmDyLxmxH/9CLin73CKUQJ7rPndbUrLiLHbSxwkqtSO5e9rfLcogVpM5mhZ+4yq9s
 YTmkEjaBfuxdz3cClrs2WK57sb8Yjp0rPSpUHS5Zqngy+InTqc+bmzKhkodxtt6iWoeI
 D8lQ==
X-Gm-Message-State: AFuF++ku78P6ZO4u6DtSfYixJ3EV99wobF9RmBMN06P3aqLT3XYEcTSt
 hFkPiGGeNvnJQw4JJXZfN8ljwjdPnacAZYE6AN4+lq5SD/sKZfQhCq5n4ttmoQvIsUc=
X-Gm-Gg: AYBFou3/yQ1BkbBqPUJ0DwnrfS768KUlamjWXXTpQXWLtKFKYTWVK6BDIYtHnVlHPuv
 W3asEU8NCzrI7SkHXVSWwovF1kxpBmXRz6YkBpiQ+q64xRj+HQUezPHX9vuDPy31waLWtMZBtFt
 Z5McD+A9N98i5BWQnwEF9TzpgVKr5AH3el7mwnsI71/Bz2dk8ELTMKKAv3UBEzBHrXBalv15hUi
 NcjL8uUYeV1QpRlpBwa5BRj4p29AssXg+rzZ52vtEVUUGOxcpOb3u4cJSRfNQg5ODp6VUWjDlON
 g+JEUMdGFfPX+M7JZVE+4P+yvHMzE9Xgig1kmxnsx+bPEuSdrbGHoJPJLPcLY6xsZAR7AXGhk16
 yLlnaV0VrTJ5FNaPo3++/jFclONyALyo0Neu5HusA06i5QEycLRAo2xX03kHPOEVj2RcmMRUV+q
 5EQ7oTTfyCsaIQq2A+wmJK0KBgscvbbYqhvLv0yvR0TiRzRydvY0+Cc2f6rO7fIgzABIIzYSMim
 12TYY9R9JMxWStcy4f7RmRuhtZFblWqTrYHo8VHw3tT9pqf6Be478G2nQq8IGboF8ZlO/7yZ16I
 cHN92cr5tQ==
X-Received: by 2002:a05:6a00:1584:b0:872:fd1:7c16 with SMTP id
 d2e1a72fcca58-8720fd18485mr261050b3a.24.1789501131037; 
 Tue, 15 Sep 2026 12:38:51 -0700 (PDT)
Received: from DB9PR08MB11896.eurprd08.prod.outlook.com
 ([2603:1026:c02:415e::5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8720172b0absm89666b3a.37.2026.09.15.12.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:38:50 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Request for QEMU PCI device IDs for Cnuas.io
Thread-Topic: Request for QEMU PCI device IDs for Cnuas.io
Thread-Index: AQHdRUdOmsMSxsk7qUqI8N8LUY28rw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 15 Sep 2026 19:38:47 +0000
Message-ID: <MI3PR08MB11878E78F75DA255C48DC4203F2BA2@MI3PR08MB11878.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: none client-ip=2607:f8b0:4864:3b::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-pz2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:14:54 -0400
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

Hi Gerd,=0A=
=0A=
I would like to request two (2) PCI device IDs under QEMU vendor ID 0x1b36 =
for the following non-virtio QEMU device models of the Cnuas project:=0A=
=0A=
1. CnuasNIC (QEMU device name: cnuas-vnic): a software-emulated RDMA NIC su=
pporting RoCEv2 and native InfiniBand, with guest Linux network and RDMA dr=
ivers and a standard verbs provider.=0A=
Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/=0A=
=0A=
2. CnuasGPU (QEMU device name: cnuasgpu): an experimental AI/ML compute acc=
elerator with a guest Linux driver and user-space runtime.=0A=
Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/=0A=
=0A=
Each model needs a distinct device ID for guest enumeration and driver bind=
ing. The allocation is requested in preparation for public release and upst=
ream submission.=0A=
=0A=
Cnuas is an experimental rack-scale AI/HPC emulation platform for functiona=
l experimentation in academic and industrial research and development. Its =
architecture and device interfaces are described in the public arXiv prepri=
nt paper:=0A=
=0A=
Cnuas: A Software-Defined AI/HPC Rack-scale Emulation Platform and Hypersca=
le Data Center Facility Twin=0A=
https://doi.org/10.48550/arXiv.2609.15889=0A=
=0A=
Website: https://cnuas.io=0A=
=0A=
Thank you for considering this request.=0A=
=0A=
Weqaar Janjua=0A=
Packet Five Networks Ltd.=0A=
Dublin, Ireland=0A=
https://www.packetfive.com=0A=

