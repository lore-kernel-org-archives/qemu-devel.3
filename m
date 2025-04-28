Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ED5C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 05:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9GoF-0006TD-0E; Mon, 28 Apr 2025 01:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gng-0006SZ-O6
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:05 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gnc-0003tX-Dn
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745817180; x=1777353180;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+rBWwLccDnt+3M46adbZDiG48Ov/HlIQmH6rmQf1myI=;
 b=UeeoufW7JIjyc+s0ifDWkzu2Q0J0WOQ1B/eYJQUwQLZvpnEvXHfBPd6b
 vt2iVieGxWdjVyKBsEVOyG0vNt3O2h3VeiPCBQ8C4KCW3JUnNTB+yYnW/
 NAAEKrXmqgy2kvhqLRlFdZPqIp2TQXrXIoUQuWb4MIyVS6vTyovhIJCVV
 qNnTTJiHWhlRLVlzdBhNfazdVW/bl/0E70dW5os1lF+PipnygwuYvDThV
 S52fWl6yJDq8W+3nOvC+sfXFBxfl2Kqdk9DVMFoglY8zLNZZF/QTNpL1Q
 5CARlpDQKEdj0B1iuO0H1Rpl0hWKdrrvF6NWUzowpZo7ULZ7kMQf5+80m w==;
X-CSE-ConnectionGUID: If+T47QDT1OP2BW1AWYhng==
X-CSE-MsgGUID: eoev7LpWTMSGTrJ7uZKv1g==
X-IronPort-AV: E=Sophos;i="6.15,245,1739833200"; d="scan'208";a="35826823"
X-MGA-submission: =?us-ascii?q?MDFDKIrcvj8mw3k1xeYuLYHRx1SAKlMgd/SRDU?=
 =?us-ascii?q?NJRZrqrGUg8pnXTobPRT4GzbciAY4n0FuK+u6Tv7s4Wz6S0eKXdJSgsp?=
 =?us-ascii?q?tkhcUtosUSJ2859LdF1acdl5/+V4FrNnvR2MKVJbrKjKWgwUufaOEXHb?=
 =?us-ascii?q?kYXomgDSqA//2V88DEOO2ruQ=3D=3D?=
Received: from mail-westeuropeazlp17011025.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([40.93.65.25])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 07:12:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INR16/2MLD9nIdhnYCeQ6ds+LICkbVtkNP2jP7rCZnai6YMNOma//JSBmOC/4ysvBqDFhp7JKbv4KqhH1ou3LEESR9p6qGGyWxkl/Q0crRTux8p3t7EpmMDugnzeD8v4zHX4O2rsciTxlDEcI9gKwdrrbJ4iNWOdTRPXEThvI7bixfigcyH/RAz31e7sUbuVfRV44/kM8vg1jADHPehjcPlPHYPDR8QCAEFPbZ3HvuodQXtYiFMopzsSTbNmUHg74jFqOpLa7OfUtt30scwK2QZJRbvynihguklZCyaIYCMcxmPLoKXivk7x7VsuxB9F9pMkstvZM6bFx54C5LwqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3vbbyDLOdZa1e+HZX/ppU9MU34FyxUfX/Bwbzx3RdI=;
 b=q+Zm9fklsEtYcuN279qzIiy6D/dA2+QRFzVwwsLGCGE/3GUk3/p59xPWydK/CHvDfTaQaltYfm5OWmyBd/vN2SstyLAiwIEHVBScaTMpWSS0vzcRI9DQjZ/z34mKZCoHm7Y91e+ZZTcBqu9KCUY7HQo+Qsl5+oYnwoH6ixlUsNbsJuNQWGjAp5RXlgapJR2Vldjj6LpoQJpBg3C18TiFkOo6P/9kINA9ZXz23qPCpeJ+7rUKVV813OPkikPpU4n2JQrzaENYNcOHhhqSMSZxx/pKelnoFFTfTlKLdWpmtgF+zTcvT9BTLD50nRSEHJCa7fLCBLaWYAHunNMSknkj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3vbbyDLOdZa1e+HZX/ppU9MU34FyxUfX/Bwbzx3RdI=;
 b=AKpDIRt7+fTjd8D9hL9WedBSPl2oX/OtpDyP9Jvlt3HBpkRCv/xiWBO/7RMYEhOKL7Hu0g+u0D0l3xDyJGg8HXm9QLCWHYia+zIU6Lxrmtfzsaq4okEjjizJbDqPr+BkchRRV1QgYjKyquzMZBQzJ3+sxis6gAzk53r7MPIP0nlTV/+49L7O6/9ItPBFr3fNsuzOf5I9ODpIliPWtco55bRwceG674Z3KOmJNjfSqPQM1DQ8G488HPoUNbco7hhXK9TxhobK6oXqvfc1XTQ9fs7Jxqbg5fdwtJ8gRPOPSzK8pWrL5743+XXraP/EkTBb7XJSWMMjbJssRWzTbfehjA==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by PAXPR07MB7774.eurprd07.prod.outlook.com (2603:10a6:102:135::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 05:12:54 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 05:12:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 2/3] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Thread-Topic: [PATCH v4 2/3] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Thread-Index: AQHbt/wyEJUoGjNkjUqvrBErVImAKQ==
Date: Mon, 28 Apr 2025 05:12:54 +0000
Message-ID: <20250428051235.10767-3-clement.mathieu--drif@eviden.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|PAXPR07MB7774:EE_
x-ms-office365-filtering-correlation-id: 7a030b4e-33a9-43f2-7825-08dd86135537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rN8nId8tcK6y+rOJp1OMgdc2cr2OqhLzznHdLoIKw1nFN80HffvfloxXPU?=
 =?iso-8859-1?Q?krEYQntGZFg9tbFIK2gDDy7RTM+Y7SAn642JQ3AZYZw6pPUOgTa9eELThB?=
 =?iso-8859-1?Q?rw41vyaWLZ8IGwooS3DSC13unIBk7Y9ROVTV0D92XENxzkjrW9QkHXX5tH?=
 =?iso-8859-1?Q?yDUbTIUnRqnGwicYKdLKtQExTT9AbcHaFnVCWRaIJd6vWMgfV+z9QtC+A0?=
 =?iso-8859-1?Q?ZiA5l7UjmpXAQVojpeAH9jBwP8eSunTh10ed4P7BKsnB1XKn/4ijLfJ7hB?=
 =?iso-8859-1?Q?Xg1cJCKY0/4n1crnjn6v7KGciYqZ+TQYrEP6/2rXbwJJuB0FzDdvGceyix?=
 =?iso-8859-1?Q?whcRWU3YBqFuEzrZ5uJqqjuVDkn4tWou4cb0sUPn/DMLqGxHFesrCiOs54?=
 =?iso-8859-1?Q?OF10i/q7YBkMN8uFunJboAKTyS6CXuD/JczPrG9jqeASfASzmds5gW+1kC?=
 =?iso-8859-1?Q?oVoUir/EXyTGVimcatO2J/rAVUqSx5yjDWdtSBxNYQwL40Vcd9QvHsClsy?=
 =?iso-8859-1?Q?J6TUmurFn0MZnGhBstV1zekMA8z1Z0s+aknoAjx5TjnRZcFrD5yUt+i3C1?=
 =?iso-8859-1?Q?cYu1h2+AqIOg87GWrZr4yidzym+vbRDZG3txQCqzUAvvambGw84X1rSL5h?=
 =?iso-8859-1?Q?bAAt+VNYsEMVbLOqDsXOHpWyVYUITAciMO6wkM/huDeiDjhtuOAXxFAtHk?=
 =?iso-8859-1?Q?wLt8yDTwBoOeBlG7q5XPBeqFUat18FyMUmejtO+KKwrtRyWct6Ks97e5Nn?=
 =?iso-8859-1?Q?Giu5HSNjXJp5p8VhpwBSka6DnMlr4vJnbdlE8NU07RXPva8Toy+kFmGTc8?=
 =?iso-8859-1?Q?+fzCZzvB0Dqs9P/pvWzESXR8vqhej68UHvrRq/tgXbfZpes2O6KZyhWoFp?=
 =?iso-8859-1?Q?s+AjJFlAxGL0S7U7bl+MWP4AkZpTidp5XWOBdMbrA0PSGIWYxKnGWmw0EO?=
 =?iso-8859-1?Q?iX68KKJlDYy7tOZ2Wv0b5iWEMFHgijxwrk1h7Say52gyIjERBxlqmpA4Et?=
 =?iso-8859-1?Q?lcrYQLHJEO/7C02PJgh1Y1Urxi8iE1pTfmka+dgadN+dfhUemEmMrlYtE7?=
 =?iso-8859-1?Q?qunlpiytNyuvwrpFcEVVFhq/1G4kWFt8Rxk8eu+gNVYffwnQrOPofhPWAT?=
 =?iso-8859-1?Q?0CE6ckOyyPXUUjzLCxEQpf2Ol6jVHCqEiPRsijIAW6zxNREcQufeJgO42I?=
 =?iso-8859-1?Q?GUgVA81SoTZfrddtzquE2i756aNmHDqftO1qDS4puE8qJaQagHDlrd5sFL?=
 =?iso-8859-1?Q?n03nZ/SWVTX8QmY2DYJuDWm6y4mAYQUfec0oD9vocsVQVZQWYnnnPjjYu6?=
 =?iso-8859-1?Q?5ZPZf0gsb8GAp3fY0XsgNGuNWQNddB17Cg7ZS6J1OKhq+zjc6JAujSlRBC?=
 =?iso-8859-1?Q?EASzG3aNho5nScSHPsYaFSjLJ2rwADqZVll0KGgTsd0eZj3p9PBj0809i5?=
 =?iso-8859-1?Q?csCb82ojTyo0vbX8qxSlThAYchBWKltjAcgr228NE+GqCqzO2ioyi4f45h?=
 =?iso-8859-1?Q?4G9qsVQB2wUVMr7WL9FNV+3tC7wqU8gw8kopzsmzVrxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V/D0ca6nOgn8xjv8+GvQC1LfVaFYC8E3KBESYMDaedDXTgNb83B0roM0s5?=
 =?iso-8859-1?Q?DRnLOmuK34gaMwofHOK/9f0FtSRIIJxKYgJgrHogFPy7Wy/89EXF0KnNB3?=
 =?iso-8859-1?Q?Yn/LZzLzsSoygi+3Y5Gv1EoxOsah/Zq6zgrOOkiDqLbQuzlBlQQF6rZ8Ge?=
 =?iso-8859-1?Q?0ZGjzQ3hdxubVck3pTcsAbG+JpE7bMqqgnRd79zPFZY1rEFk/H1tr2IKyn?=
 =?iso-8859-1?Q?iijDUKdpAR2CqUl1Ih/Zqs98RMA5jQmZL4Qa5tiCFP76gi5BQ+E4b8En9H?=
 =?iso-8859-1?Q?XkPWkGqKOJoaK2ryl3vW9MaFP2unIQfANc5SpYKlRrHMoC3Ho4d7pfH/eO?=
 =?iso-8859-1?Q?6mRst4Dgl/+bW3rY7dieMcO/qiD99OFzMktgNnxCwYVnoVtqP/yKAPcVJ+?=
 =?iso-8859-1?Q?oragiVES0uHi9pBIWBTVJnSiUP7lSlTu8AtiQ19EuesGb8zjru3A9pNXxi?=
 =?iso-8859-1?Q?H0Xlmx/py5Tf5QamDYVDw9WLNVA6EdpX8ENwWYmKZtuXJ1liVah8au1/Z+?=
 =?iso-8859-1?Q?1c/ZLhk7L/a+toOSFyOs3D33cMOjcIUGPrnse80plIh+A+j7B9OtxJm+2y?=
 =?iso-8859-1?Q?wCNAnw1yu3wcI9o0rD9HqpCtoiyYj6BVMkxi/oV4e17ueu1yUaX1MzEffA?=
 =?iso-8859-1?Q?PleYVc58Jbbm0d/TMqYY6q6g0RpnWaj9qmRCks8uPflW/7+mv8jipd3amw?=
 =?iso-8859-1?Q?e2o3mgBd2BYjK6peVqWWXbfc7eGGCfo3qys3WHTAFeR1v8i307YpvlBC1B?=
 =?iso-8859-1?Q?x0fT5lLriuz0Z7XCcv7WTXp4gr0IrGcGpSTdKDST8gaRngEqaAsI6hvUnF?=
 =?iso-8859-1?Q?2BQcWIcvX3em5txho6k2ysah3kzVxqCTcvREOl/eH2I0A/svmQoqzNjekR?=
 =?iso-8859-1?Q?OJDuKJP7TWZV9elqamFzwI6CEbPZNu4OjQ5mnGrRgb8hWjLMZEK1witnRS?=
 =?iso-8859-1?Q?CA6jDcYmj/Xw837daeOBTjIgDPECiBcvI1/SKgsPena/1pcIYKCE18kCvS?=
 =?iso-8859-1?Q?kXRb6sdB3X6B02Dh+a0095B+kBuJHWR/3bHZcQ+Zg/WU1iB1I8zYGP9sU5?=
 =?iso-8859-1?Q?h3VhUNaWaHHROBmGuevjZ40iGY8YzfZXlhb8uJZeOgd5VDzytq4tQsb5Qj?=
 =?iso-8859-1?Q?AMLPh6bKzsnenm8lMfwuHIleQ9i9JinWi6LI+G+hjqapD8rQMov4knFK9u?=
 =?iso-8859-1?Q?GpLFdYA7hMWdHUNq+l/ZF3xitQ+yaWKpshQtfZ/4ggMHO8L8UczviDlfXr?=
 =?iso-8859-1?Q?CjF/UdRptoqY/u5tBkhokRRM8KscuWYIstRyZ/UPDfoEO7Ou/Us5jC/e6U?=
 =?iso-8859-1?Q?35slXp9aP+KANr6lQl1qDYNHfiyVPcmhiXSAUm8IuOCWz9r9HhoatfH/5w?=
 =?iso-8859-1?Q?uB+aCj2B+FIKoYKa0B23/rCLl7Dj6iJV03E+sdO3rZIRwovePpC/ougkTD?=
 =?iso-8859-1?Q?8s7wpGXqSN7jkUdgZ5toDQTFiJC6MwocsCUbKW5+oPs2qDrffNxWNBcVuw?=
 =?iso-8859-1?Q?8oKf9+wFvhLP+z+GmEyqtLzUPTVD+SUyt9Hv8CbuHxIYp6dndyl6MBUccS?=
 =?iso-8859-1?Q?daVlXPtQbsS3030P66vq1rm3qJDFmYqDPvDd3+AjnDMoEnQ0ymTDuAbD1M?=
 =?iso-8859-1?Q?/k3fhZU4C+fH9tk+Rsa8xz2TcQGfVQ6WEIPUZ4IdDvHVFLmGKNlOB3Ahbl?=
 =?iso-8859-1?Q?SFSclucHxx7eMbqtxuc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a030b4e-33a9-43f2-7825-08dd86135537
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 05:12:54.8319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLlOEn6qo/we4/tsqPK/muWpshLY97v8+XV5NGhKvGfpD/1vRXF1MyfpGMoOmWEXVJ1mY5U33RgFJ/v4UeSeGd0w9QqbSwsVnrSwC3xhYwjhFfvUuYxOOtxEiKVlrFep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7774
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vtd_switch_address_space needs to take the BQL if not already held.
Use BQL_LOCK_GUARD to make the iommu implementation more consistent.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8c9857e1..b7855f4b87 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1728,8 +1728,6 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
     bool use_iommu, pt;
-    /* Whether we need to take the BQL on our own */
-    bool take_bql =3D !bql_locked();
=20
     assert(as);
=20
@@ -1746,9 +1744,7 @@ static bool vtd_switch_address_space(VTDAddressSpace =
*as)
      * from vtd_pt_enable_fast_path(). However the memory APIs need
      * it. We'd better make sure we have had it already, or, take it.
      */
-    if (take_bql) {
-        bql_lock();
-    }
+    BQL_LOCK_GUARD();
=20
     /* Turn off first then on the other */
     if (use_iommu) {
@@ -1801,10 +1797,6 @@ static bool vtd_switch_address_space(VTDAddressSpace=
 *as)
         memory_region_set_enabled(&as->iommu_ir_fault, false);
     }
=20
-    if (take_bql) {
-        bql_unlock();
-    }
-
     return use_iommu;
 }
=20
--=20
2.49.0

