Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED03C43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNK-00035p-KW; Tue, 14 Jul 2026 23:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNA-00035I-Pj; Tue, 14 Jul 2026 23:33:24 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqN7-0000nz-F5; Tue, 14 Jul 2026 23:33:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHXySL1p4QOh2FJ4552joOYecCrxrtc1+O/D1WXy9BYEKPnZSCbFGdmFsRFF/2UtvyjM55g8owVFw6qfJjjLjdxapNr19Sp/sjTmEdm3f48lNMsJs1lXZc7u5A6h2p5cbjGUGFlreZESrooX+/fDml+sqzTZsgaUeCits22EJQQQxyZ9Qwj/E4IVX0nwI8NkU334XvrZCitCPS/69DXzlZZRzDpYmwVdpHHYQjH08GAe29ndF6FnmhTJICiVJttxApM5G5Ar0H0eafsK+t3RlmFUIH2Wz0HBKmsspsUM6Srxbi4iaXZwtg3QTKbmaXcPIbs2afA1AuLqZm69+gknag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0gT26UhG3mFL0vz/a3/fzukYc47v6eLi8q1+P49rtY=;
 b=gvtE1ART1XjFOeO4wIVoMG0yQR+cHUAlD4rGyxaeJtjPAPeD29RkLzLm9K1E75UkahsiYzcFvsv8/5rD5BJm2y+paxcsy1L6t5VhhniQVfgOSgIB378Ad4MohXPZO1GoY9DbypjM9vnONzIIGoxIyNpk3m0Zt+i/nJ3Ksv+bu75NUtALFvNUCeiYVADZkhd6bQXrQHYhGmXDiv29Ca3CsFb6X80wgB0qfyMPLydVplbfPTVH4o7BUIvRWkB5f7zwvq5lnhdPtjIb2eNMpGcrMjKxClH8nSqqsSFxxKT1MONHTOffA3HhdBZmu6cdt478OFipgpANiEG81s7yBpGRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0gT26UhG3mFL0vz/a3/fzukYc47v6eLi8q1+P49rtY=;
 b=g3PO2MtojXS5/xVSIsnXMjl3tsIG6ES9tIaP6p19WeqXb/drdZ1FlS+HMJJJn9roAhG002Bq3tkielmdvspjGZLQprjyD1XcfPSL4L/ng6uwfM9IkkUeNCKJIIVUrtgGXJvEuqdcJeJ1TDuFeutP+WSSuhv0hBnJCTjinYE0RitOqrVTHNmTeeqfRrnzmAmXN8Wv6HpiSSyQIqOWwNvsqlCLPVfRWU6Wycp5hso6GU9N4jyW8Q6qPpuRrWdCO9bKF/eIl8ULbB72+smNq4awP+qTJfwqYSnqD3+9hWz4uVa+Aqg3Sb4ImmafX7kicqpoo+TAt+IXDjW5ilpSEeSNTg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:13 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 00/17] Support the ASPEED HACE crypto command
Thread-Topic: [PATCH v2 00/17] Support the ASPEED HACE crypto command
Thread-Index: AQHdFAqq6748wRnzUUGbK7NHljVplw==
Date: Wed, 15 Jul 2026 03:33:13 +0000
Message-ID: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: cb6a4340-abf3-4f6f-54e0-08dee221cce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: X3nvLeOv0scL9R/XEBPun2P99mxetVJ1BTosxvP1Rhwg5SJveyHB+mvYrhQpTdGexugtx9qeSzhqbnxCg0fiq4nYZ+GXLI1RFsFQnKvfdCLAocHc2RPLPCsUWmIDhpU+/PrhgfUPZZUHxTy+5kaaBJszan5xeHbFw4kH/jpzwIVEAMCWbWHhIEo98uO7Vn5Nty8AATr0/tPzYQkaaGXbPjNwIFTqNZx5P0OEuNj4+5x2o0VSqeDqmHZU/r3ChnJyDPYSRoIsFUMrmKcs8IKS+6ynCod3yLcyuIQTNqVOKeY8xC14BioArE1oeUSykrg+UPoZSzLSphaMtVdW4OwNy3OeIm/BPEuOU0IHMyR7sgDEOXyeb8iPwRRajD7Hzdtx7vqdFRMM3nY2CVVyN2MyNCL1sCYWm1+pazJCsltA3zYGzaILElexSDCgKLgYVRrLCObcMKhBkIGfl9xg1EfWSxBe3UJ5FPHCp6Q1CCiBNRiLrBafP3BWilKGs3lUzYAnGjYnmi8rcAy6vjmsWtyZhBymCA/jkKeXDbmLOY5j1St5Gfo5HPSVLV3+idkkWLpQj90NwrFdwLjn3gRRnYPT0mFLzaRqiNoo6nLj6TP3TryjAHhqyBVszkhIXlDWpycenUDUjiomX3npFVYJUNBSx5yEeiYLvuIfSgcWDP6jjCI67tiATxE7+9iM7go0057ar0Cpeh6Wzan+aWAfIuV4pGrqZPi8lJIXjLr5Y+Z3wh+7bOBn2VYgp2nqb1C5GCos
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g2zJYjQnv8ApXekjYUDoJ3qORiKVNpfQDs6EhZCoLCZGw3KASCmNE+6J9d?=
 =?iso-8859-1?Q?FFikdIBcsO8d4eKN70iwxfpb+MOi/rnxgwaUH6/3y+QWeMwUcnu+zQwKjQ?=
 =?iso-8859-1?Q?v2Znc4P8dN1Sm0aAp18Std91efwksGK8TupPQxGG2UXVej8rlexDFkVFwT?=
 =?iso-8859-1?Q?npU9VY3iv2gLAAO/m9tZ4dyLIpa+uFxiv9On/MBYNIce4+xqnRAh/1JjP7?=
 =?iso-8859-1?Q?Nvl79UhOtbp6kJz7Gk67NelgSnugtpKW6t2hUB1A4/z0pn8NiXt/1+xfIA?=
 =?iso-8859-1?Q?dAbKLlwbypF7bIREkc+YkOZ+CFVvOJOzonhh9QcYtLECUi0bJfZr0fVcVk?=
 =?iso-8859-1?Q?k+XtF8lezfaQFSQoz4q7hpcfna4Q215VgM3a5dNabbLsu80J3OepmOO+e+?=
 =?iso-8859-1?Q?30Y7QJliqcnrbnjIlTMz0Dq8bNemxaovnvzTRznbdJQbZirlp3zjqcvpYT?=
 =?iso-8859-1?Q?AYyZW8+MuF8NWKfh3MmUEIYdpVQwcMnx2e/lC0RMtXlONhou0RA9CnnuAu?=
 =?iso-8859-1?Q?1Rw3Sf7pZeFzTC5G2yfIYRwWyU58kWbN4Fzvdaw3PW/YtVDT6LBK+SnKse?=
 =?iso-8859-1?Q?mOhfjAGLPMGfpSVqqb9ZbiJwxjroVrpk11Fp63VhANEoy9s9w7QUv+a+qC?=
 =?iso-8859-1?Q?0f8lPdo93XgcGox9x73sWDRCTl47LSAYpgqAEyoZZlHPlQ1lvqNq+udL9d?=
 =?iso-8859-1?Q?6bOxkKqnmaAbh2GCE7z18usaqXRuOQh/8Bcbbb54hWlFtnkTwOGpdLb3Hl?=
 =?iso-8859-1?Q?H8cRIEZS2ril098/lXWN6/aBxTHabD5Ir6fTXIMwdZWLJX4pnPkCpcPy99?=
 =?iso-8859-1?Q?/dVsFv0Or8f28jqfD7f3iBtyNqn0iZfVp7hZLvi27dNcqvjahrZ3eosvL5?=
 =?iso-8859-1?Q?9bU+bvvrzhBL0vHavvbJPQeoQh+gGN7XnEuLxD68osrhBu8pj7DsXRQwnY?=
 =?iso-8859-1?Q?rv/FDowZizRaAX8+NNdjONhamknx98Tj3mhl8y1aokBbhBYhKpiTwfN6Dh?=
 =?iso-8859-1?Q?fFRHwKf5XkwYKV+/55gvERo2RlTc9ofql2OzRJLiPRang4nUjFBEsUaPI8?=
 =?iso-8859-1?Q?/HnxVFA/d4Dc0AnGgSiNkok80+2e0yx5d3u1W2h0vYw6Cd/yguInTaZOAb?=
 =?iso-8859-1?Q?q8HBXUh4E4T55m+LKsl4ijcPCNbzDEmeiz8apX3Rl6tO3R3JjNjErnvoFe?=
 =?iso-8859-1?Q?SPtKO8Bi39wsa1h6EJMV8Asqvj56ZS4iAvE9r8Sx/WiuuQOrkVK0VHJ9ii?=
 =?iso-8859-1?Q?Olgw62hATeODzf31zSTy9bLTpkCr8ZQ9CSGGirpjvg41M6Tb3YpCts/6+C?=
 =?iso-8859-1?Q?vsqdKeRsL8z2xUaZuGXthbAgrHK8aeZ9eD2mCYen8dh7BgHlhwQR/vrnJS?=
 =?iso-8859-1?Q?hgCNsQquwoDBSrwCdyrsLSZl7/wxEqJ4ija8OOWNAP8ADGJEbMCNBu7F9Z?=
 =?iso-8859-1?Q?97C7n85EZnIEK7WJkq0/NeTnHXPFBslrdxUD3y7fmToTGszEid1La9yDrV?=
 =?iso-8859-1?Q?Xrt+Hahu1nlOKTC2Pz2vFIBYzSO5wsMUXdWdrHKo77m3i8VC5gNYLiEhAH?=
 =?iso-8859-1?Q?1lzbcwmOTqcdy2Zn9stZunVG484BKXPOLlw6LiZxTAVJuNvEQfLG/zO9ro?=
 =?iso-8859-1?Q?d9v2e6X9wYqJm6SewPsPShkQeMvc1xzLs4hEyJw6EIh49y6pcc1KAH9IjU?=
 =?iso-8859-1?Q?JQfdlfMOMsXScOemrEP7btdIQG/Z3KWQTBRft0VdBt0BjUcd6UoTXORTiz?=
 =?iso-8859-1?Q?T8UTgRMTgzdzGkwFp49ahPY605L/IVds2KsABLBY4KQLnLSbzWQg9IDtYP?=
 =?iso-8859-1?Q?KEhAK3zc0A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: APJp9CP6LnjWCpiW9G2qPISdF7SMpR5gutsIzt1ZcgZqNIysdN9jcB9TsBf3Kz0RDgdin4ExNIxnmc2H02Tdllw/gjbI6DXe0WE5Kgy85WiUSCcSY+PFfMBSZEbNyboj/6J8DbR57+EiJ/xHhC3IUwp8ljQ/uLuwx+ZlZza0Sb4v31v4hkia/MFQpu92ZHOK9kBlh7SzQdvkWNMVSJafBy3bAxDYnoZUNSsu8bnTerxodG4aaF4QMSCh04jsvKhf7MXe8/oF4LcDXX5bgrdEZlbvIuh+HUV3O94oxA38nMdlYNSQ11tVzE/iN0NY5XE1CbY7XF7DRMhTy3bdNDoA8g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6a4340-abf3-4f6f-54e0-08dee221cce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:13.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7krXPtwgT92BmI9Pcxg2x3mb+rNGaNLjCDMsxD5OJdwfXZSQULwj2fFyjPAPytuIY6kyzPY75mn0BH4n2TVY+AbVwDM74tP+y/fuy1hptZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ASPEED HACE model only emulated the hash command; the crypto (cipher)=
=0A=
command was stubbed out. On the AST2700 the kernel runs the crypto driver=
=0A=
self-tests at boot, so without crypto emulation booting floods the log=0A=
with failures:=0A=
=0A=
  root@ast2700-default:~# dmesg | grep "self"=0A=
[    6.078446] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.079295] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.089924] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.090629] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.100134] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.100416] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.100576] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.101411] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.152954] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.153701] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.180101] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.180747] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.206437] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.206910] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.215313] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.215698] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.227173] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.228027] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.276878] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
[    6.277541] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
=0A=
This series implements the HACE crypto command: AES/DES/3DES in ECB/CBC/CTR=
=0A=
over direct and scatter-gather DMA, and AES-GCM with 64-bit DMA on the=0A=
AST2700. It also adds GCM to the qcrypto cipher API (gcrypt backend) that=
=0A=
the AST2700 path needs, plus qtest and unit-test coverage.=0A=
=0A=
With crypto emulated the self-tests pass, the warnings above disappear, and=
=0A=
the temporary 'cryptomgr.notests=3D1' boot workaround in the AST2700=0A=
functional tests is dropped.=0A=
=0A=
v1:=0A=
  1. Support the crypto command in direct access mode=0A=
  2. Support scatter-gather mode for the crypto command=0A=
  3. Support the AES-GCM mode for the crypto command=0A=
  4. Support 64-bit DMA for the crypto command=0A=
  5. Test the crypto command=0A=
  6. Drop the AST2700 crypto self-test/model workaround=0A=
=0A=
v2:=0A=
  1. Add AES-GCM to the nettle and gnutls crypto backends=0A=
  2. Skip crypto tests for cipher modes the=0A=
    compiled backend does not support, via qcrypto_cipher_supports()=0A=
  3.  Check qcrypto_cipher_supports() before running a=0A=
    crypt command and report the mode as unimplemented when the backend lac=
ks it=0A=
=0A=
Note: the gnutls crypto backend does not support CTR mode.=0A=
=0A=
Jamin Lin (17):=0A=
  hw/misc/aspeed_hace: Support the crypto command in direct access mode=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2500=0A=
  hw/misc/aspeed_hace: Support scatter-gather mode for the crypto=0A=
    command=0A=
  hw/misc/aspeed_hace: Support the CTR mode for the crypto command=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2600=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST1030=0A=
  crypto/cipher: Add GCM to QCryptoCipherMode=0A=
  crypto/cipher: Add setaad/gettag for AEAD modes=0A=
  crypto/cipher-gcrypt: Implement AES-GCM=0A=
  crypto/cipher-nettle: Implement AES-GCM=0A=
  crypto/cipher-gnutls: Implement AES-GCM=0A=
  tests/unit/test-crypto-cipher: Test AES-GCM mode=0A=
  hw/misc/aspeed_hace: Support 64-bit DMA for the crypto command=0A=
  hw/misc/aspeed_hace: Support the AES-GCM mode for the crypto command=0A=
  hw/misc/aspeed_hace: Enable the crypto command on the AST2700=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2700=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Drop the AST2700 crypto=0A=
    self-test workaround=0A=
=0A=
 qapi/crypto.json                              |   4 +-=0A=
 crypto/cipherpriv.h                           |   8 +=0A=
 include/crypto/cipher.h                       |  36 +=0A=
 include/hw/misc/aspeed_hace.h                 |   1 -=0A=
 tests/qtest/aspeed-hace-utils.h               |  20 +=0A=
 crypto/cipher.c                               |  32 +=0A=
 hw/misc/aspeed_hace.c                         | 461 +++++++++++-=0A=
 tests/qtest/aspeed-hace-utils.c               | 693 ++++++++++++++++++=0A=
 tests/qtest/aspeed_hace-test.c                |  18 +=0A=
 tests/qtest/ast2700-hace-test.c               |   9 +=0A=
 tests/unit/test-crypto-cipher.c               | 240 ++++++=0A=
 crypto/cipher-gcrypt.c.inc                    | 101 +++=0A=
 crypto/cipher-gnutls.c.inc                    | 154 ++++=0A=
 crypto/cipher-nettle.c.inc                    | 128 ++++=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   5 -=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   5 -=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |   5 -=0A=
 tests/qtest/meson.build                       |   6 +-=0A=
 18 files changed, 1887 insertions(+), 39 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

