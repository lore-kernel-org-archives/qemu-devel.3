Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DBAC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFo-0001A9-Gx; Tue, 20 May 2025 03:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFm-000199-AM
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:10 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFj-00028B-Ml
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725548; x=1779261548;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ShJISvjMrZqtI4j33FDslHorDGP6GHL2m3QaVL6SxKg=;
 b=g+uzQbLflGpZSSL5Z7cdj7uS5fNgzkYWJxT3pWEBLhfQn2+bOvFNExGI
 M6w1yJn4RcxbLXDzdbeAmrE+W8vK0N+UF7yd9Za1gxI9/GInKZklbzR43
 QTZPSGDYpTJzxAymbPFb2jT+owg+MSmHH3mLa5q7Y7XQxlrxbp8LNublu
 fwBwfJLY0K4mggs1wiJO/ofLyzJfze0LJpI491Rqs3UOH83p1kPqyiOTT
 0E+BCIbvSJk+ZGYhUpQ9nnXEtse9cNKR5gVrb4F+dvxLkhPJ5YXFlqTA2
 gnZKX7RfSFO5jX1mFC5uqb2Azpf77GhpF1clUi94suVqDxajIH8W/m1v4 A==;
X-CSE-ConnectionGUID: u3Vd1TXXRZKcCOs5S9vCIQ==
X-CSE-MsgGUID: yaNmwBsnStGESkPwBPoZAw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37191613"
X-MGA-submission: =?us-ascii?q?MDFIDjux/Zky0NOFzihKsl390V4ARTHrQROBbm?=
 =?us-ascii?q?3v77S2C2QXb/yzthjWIaBPn7Kc3jd030AJuMnoJ59++ga6Bcapi9QyH5?=
 =?us-ascii?q?qAYk/dnWo6dMofbidbQRJZTVbUtF8o23LGkeg+4eFCk2ioElRgB4wANC?=
 =?us-ascii?q?+WcwLjgvWjmwVtupVCLGNU3w=3D=3D?=
Received: from mail-northeuropeazon11013057.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.67.57])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:19:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDHOEbIKzjW20wtqgJ2vmP4HGXCXmBEC2xs5lR0YYd8sZLyijotE/6e8bahlrj71ZJuUNXhZE/C+9RDNyK0czQ1u4/QZ6sDq6K84dVrE7de6JQuZxN9rF+UsB0X82DLTDmRAn/hOSOyd6w/Ubfp0ELvD4K+DpVsF8bt1++4cn52gNQP964aol90+QUJfLTXkGUGtL01EfCW0vMrYY0C1ISPV3aBea2zOhXEWEHFGoA8d2FOcMsvVq8ummyOHL91kiGOGi4yUMDFFGOibjGr0E/khHy7qnafqMr17SmnHhIRNnaHv2yz+Y+aWH3kfC9T/tUSmAzIJBZ8dstAwpxS1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etlIBLlGhKnGpYVwNbiRhrNY/m0YqqcE16zSPEghsTA=;
 b=Jp28FxWLDQHJ0/WYhaycRyOHGI5l69dMPVT3NdNLN68iIs1cOSaRxYGopME8Zr4ItgaqR8eyTU23ihIyD00X5dOU/BRrGXIhuuvUFgUSFdsbUSOLu2DFrgMR4XmTaaA5cUwZ9Hvk7j49wPN4TXW4MlpwR3jx1t6PPd8wFI2oisMsLgAcXI/3zg5q/wYwaXeB3xSxjMGX/D3kfvLISgcUkcwExkd7sKinF29OEOo/fJ7G9rGbikBEDjxNCHoiwb6a6cd6aI1RUo8Rn1ELBrSb68X5g3/NtRUSXtbX4XChqtHo3/2tTzL8g6kbGwkEr1rNkN+G/J/KtvaYiGBhisDm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etlIBLlGhKnGpYVwNbiRhrNY/m0YqqcE16zSPEghsTA=;
 b=oC4zX8EwZsmyNVD8YbAJdKEMguC3XwBBBc8grv83H0yYoG7+/ppDO83jCmw5i7Af0ZFZAETo/Wp21AEWXKRW2LDrzGv661vSDwPeM9NiS38NOts9SsXv15d2OzEycoMM/PBZUTqeHovcLhQPFTTrgAoWW2JFxEbUjPs0HruncjHE3HiEeI3ld5DvlS8Y8YgkO43k1XhLhTxWvZ09HAMEZtqlaxfxyZB3oXrWFXKDh2zERnmkPLjuXW4AK3WdHxGdfzy5l+Msvx+DW7HwLjDNeQP1sl5gWO9Ghk5C46C5w6BOF9F2fT+L9Yys49ZaWodCyS6CntFOQ1IQjlTiM5cuPA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8102.eurprd07.prod.outlook.com (2603:10a6:20b:371::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:19:04 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:19:04 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, Ethan MILON
 <ethan.milon@eviden.com>
Subject: [PATCH 11/11] pci: Add a PCI-level API for PRI
Thread-Topic: [PATCH 11/11] pci: Add a PCI-level API for PRI
Thread-Index: AQHbyVd3LHi5228jY06ftVz+GKmvWA==
Date: Tue, 20 May 2025 07:19:04 +0000
Message-ID: <20250520071823.764266-12-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8102:EE_
x-ms-office365-filtering-correlation-id: 0a6b983a-0f6d-4396-a045-08dd976e99f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Goy4ZW1AJTbJ2s4FxdTxvwX964uKXgZ+8z2lXh6WBvyvwzber4FC5xElSF?=
 =?iso-8859-1?Q?6CfjyHX4PBbJ6kT3Y46bzJbpcABUM+oKEb5o89WFsboxVLvriLGwPcKHff?=
 =?iso-8859-1?Q?VLm9dJooCG4ATA+bqdgxKu+ur1hMtbHR8qcXV5sQ60JQWipb0fbY/NgLQm?=
 =?iso-8859-1?Q?+vtz8lK5F1ryReKUi0hZWSSbGnXPhGuTJaidCxGRaIrxczWtGxaHoPAUKu?=
 =?iso-8859-1?Q?0Obc1JunmOGZ2Unty2bdqK1G9JvbZ6zAwgVWQ9XmAlWAZwtIa6ywLUCrED?=
 =?iso-8859-1?Q?NGZJH/HjJbP8DV9/Q+VP6bJQzFsy3OkDLmA4G+l5lX93Wb+6Gqyn/1ew/X?=
 =?iso-8859-1?Q?FiUjHFurKlCU4LAW4uoa9lWd5GuwXi0k0Fkha3yODhTJQfSYQk/phXnb8l?=
 =?iso-8859-1?Q?E6J7ex5X3lPYDNoVq2O6NfLGUgYNZ14BJbKm3cGxS5s/+Z6dBTjNkP0dkO?=
 =?iso-8859-1?Q?rNejeIwejMJNJUnQojgUvqsgn5qG3bVFGrNcGQ+6Q1TU/FbMCpdng06HOh?=
 =?iso-8859-1?Q?nIBAhROCkEpVMqiUwBSvGlzKPxn7Rmae+ig03u8PtbO1OuIE839xIAcDRl?=
 =?iso-8859-1?Q?Zlj83Nvf5tsjXU+poEy4OkoW4eLmCF+Bx3yuHZq1gSUJbGsKNsqc8+2/Bn?=
 =?iso-8859-1?Q?upCiNBgZx+5kAHudkDHwx8lU7raVHuI1iR4z0C/0PekzE1V+DNSWU2MZNF?=
 =?iso-8859-1?Q?hx55kCi2Zx0cKiFp7eCUsRqzLSdZ9+lT8ccl/Tpiy11Fafdx93Pk1F999I?=
 =?iso-8859-1?Q?R2mBXhuDSfUBbWvWdjG5QMfDuB1Wp1fxq7q5LL9tCFaTtbGV0U3CdRLkbN?=
 =?iso-8859-1?Q?MvLabc3HiLbck7BDBHYB6mpPt9kJGjbEL5gECgQi/LsvAbHS5Knn6dSVP7?=
 =?iso-8859-1?Q?Xh0SQ6VBrqlMAa1H7c75MZrALjqOoNbKJVMx4ZCxJEsAGXQK6B1hiZroz8?=
 =?iso-8859-1?Q?qliXTulswrBprws1/8MbU9/MY4mj0Ctf1j9eYm+EQ3li0K/Oku73cXYm5S?=
 =?iso-8859-1?Q?vFx79Ii7KnxJE/tA5qRVpsofGkvn2U2z3dmqYkl4MT7G0/OU6aESeHFFnx?=
 =?iso-8859-1?Q?0EbaN7DjAguNlqjSplJwsgXDY3pYO8u/Or0eewtDV4z0Lrc6sRknbgl2IX?=
 =?iso-8859-1?Q?gfcHbIkkTwEcZk+lV/5FrrbOXJp+aFuJhJEHljlgH7UeNsvtW2ud34+8gY?=
 =?iso-8859-1?Q?VEGLUL28+EO8ByYRmkPedlhmrKqCzaVVWl/2VH+j4L1hBL7Xx9JR7mb/9S?=
 =?iso-8859-1?Q?zEJtBgd9Y2JI1nJI5gJm16eW0ei3IbogUwsY7P43OQx4gXkB7bk/oXzkSc?=
 =?iso-8859-1?Q?NKTqJnUnS3hw7TjtC2BXIp7g4ognkpJaEUA21LUcYNo010xV9/zp192hLX?=
 =?iso-8859-1?Q?3FjoYHA2AynWZmw7CfusPlo+4SZUmkwW53yXiR2CHNoFVTFQs70W/nv5Bj?=
 =?iso-8859-1?Q?COVbb9T20yrDlGzBlGiDgpqwcI87qRod56eNJS5Z2vqf3a2uHKMnWHja7Y?=
 =?iso-8859-1?Q?3Gh4KeBd4P5HjuQnA0xDD1/yUCHD1Ip+wctzMyjxTyyA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LulAWOwP8FjCzA9SiHQz5sUpFZmyzhEA40vpxE7uPSD+vJYXkOvRl6EaN/?=
 =?iso-8859-1?Q?zJWZx8ThTg1Icx92vFLy8RIShqExpiOX2artleM6HAMoAGbqv+zUo3n9er?=
 =?iso-8859-1?Q?LbZNV8k74gDlCRK8xaUxSnZF24Nq7zUPef4WVALqBuxakfaPQKoD3ztude?=
 =?iso-8859-1?Q?irwZKabJg5Zdf2w1sAu+NDYOjUc15uuV/Q9BUIkYZxJ7UL0IAcqGua6jUL?=
 =?iso-8859-1?Q?UXDySxGZVPyvRhxARlZ6+WhaIlmXCZheB7cT+9Kp4PcwHAx84bhiWJqN1w?=
 =?iso-8859-1?Q?HXr1bjqQL8FBjCBBvf15cC9uoa8lbSamfPIsbxmPAvd36zxdZcZUDakc8L?=
 =?iso-8859-1?Q?zhEQbKPbjdn6p5uRrQ9dN6CuAEzWZl128vIUa+QHKo711Xzy0j8sdAxy0i?=
 =?iso-8859-1?Q?K11YWX7LtO8cH41w8z6YhVyTm/tlWnfUD0mY9CUStx2gy9/4lb/PG13LrT?=
 =?iso-8859-1?Q?XEiC3M5zft9pB69t4uj5rzeOaoO2vdcxxCj7ZgYmFw826SaKCpVghiQ6hr?=
 =?iso-8859-1?Q?CqZO/N7pmYRjuhOSFB2+/R+dQ+OkOnS3wGIaZqrMYlHTfvAau4iW+dArKa?=
 =?iso-8859-1?Q?eC3U5Dbdi1lTOjIdWw9xTMHXoYmlv4DGNhl/P52SBoYM0lCgesZRgDheWf?=
 =?iso-8859-1?Q?dJ+gTVxwgGyuLsDhE4XJZalx8PVsNZBq4UCJgBc/QxBPQ0Poie+nLM1UWQ?=
 =?iso-8859-1?Q?5HkIqLZ4y5TQRQE+S5uM+5q7f8ENPOTP6mDX5kWySmUu6/NbIfI0jdSsXf?=
 =?iso-8859-1?Q?u4BlmZ31A3Yl8qfoIJsMnCZHdhvGOG7hTA/aFOaVcvOwmRBXuSQmuVLrpF?=
 =?iso-8859-1?Q?nT3y2XNkBtppmaJwh0OJUD66Lz1wJSFZ8bMnPnWpOwS70uAPi6KVWsuBKN?=
 =?iso-8859-1?Q?eoOGzQ5AH8gC8PHYQi907L2z/waMS4IG3ie/LUPuitqDl61GOJd45DZJJs?=
 =?iso-8859-1?Q?8N0GbHvz95ljkq4KiYX8gfnyWaQJU9+gc7KWCiU1cJkICP2bWFwwxpTit1?=
 =?iso-8859-1?Q?iGz4nWSTJQIOaXTXLUx5eU8Rj+ZZIK3gBs4hyKypKXfe3sQ14J0reX+osa?=
 =?iso-8859-1?Q?91pX4llIg47KeTFh0GZF4mX3StTJDCCOowEsr4SFB5K1UfvuoWh3XiVCRh?=
 =?iso-8859-1?Q?bIRenTeDMcAXB8HhIhcbJXjg/MReKRkIkXTT7LfN6kryDjT+ufYdD1dilz?=
 =?iso-8859-1?Q?A+vGXWFjQJd6hscGCP0wgPHHziuSpnKDPkUAaHu9gIio91m92xym7IA1DI?=
 =?iso-8859-1?Q?/8hsKWtsMp90TvDCMDhFVwkfNPfpWbumccRQgKvGRtuSg+ON5Y9OYum4cl?=
 =?iso-8859-1?Q?1TIJUCagjIq+ODFWlw7e8upP84fSK3jTGbHtqcWJ2bGZaKvuzyH7MbRbZ7?=
 =?iso-8859-1?Q?gpE4D0JpWGt7boC6p7EsuzJDHeFad6cEa8iq6pS74sGQ5TxxbkCorj91hv?=
 =?iso-8859-1?Q?UgcD4EVuG7RXhZoVMa73N8sxvSkbSe3AZRwFCg6NZ/24i0IOZ0FhgwC3/L?=
 =?iso-8859-1?Q?vSp6EYYCkGGesdleF0CV/SqkCS2SKZNEAKxksOwE4xKpv/V+qSVBqUAr0n?=
 =?iso-8859-1?Q?grNWmn9PVcwEZMYu9savrwlsB/Uf+gzQA3e94MjRWOx8+ZS+Fqjdb1yw8J?=
 =?iso-8859-1?Q?wh3yRGRpLL/OklFAjssqhCVH8IkXXK4pDzndqtylVMf+122XSOBYqaDyRS?=
 =?iso-8859-1?Q?T7ojFXewMdMkaK7na3o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6b983a-0f6d-4396-a045-08dd976e99f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:19:04.1889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyqtwGT3yhCzbNykiv6g7HP96uEyFC3tNCutmzCezvFRtUWITy+zoCT1pz/QLG4B3TsUsTSIlOkLHMLO7OoiYaVez+yJOPV/zLB7Hm/G51IWKjucOyEj5ln3+40XXlw7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8102
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A device can send a PRI request to the IOMMU using pci_pri_request_page.
The PRI response is sent back using the notifier managed with
pci_pri_register_notifier and pci_pri_unregister_notifier.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Co-authored-by: Ethan Milon <ethan.milon@eviden.com>
---
 hw/pci/pci.c         |  66 ++++++++++++++++++++++
 include/hw/pci/pci.h | 130 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0c63cb4bbe..c6b5768f3a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2987,6 +2987,72 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
=20
+int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
+                         bool exec_req, hwaddr addr, bool lpig,
+                         uint16_t prgi, bool is_read, bool is_write)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if (!dev->is_master ||
+            ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev))) {
+        return -EPERM;
+    }
+
+    if (!pcie_pri_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->pri_request_page) {
+        return iommu_bus->iommu_ops->pri_request_page(bus,
+                                                     iommu_bus->iommu_opaq=
ue,
+                                                     devfn, pasid, priv_re=
q,
+                                                     exec_req, addr, lpig,=
 prgi,
+                                                     is_read, is_write);
+    }
+
+    return -ENODEV;
+}
+
+int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
+                              IOMMUPRINotifier *notifier)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if (!dev->is_master ||
+            ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev))) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->pri_register_notifier) {
+        iommu_bus->iommu_ops->pri_register_notifier(bus,
+                                                    iommu_bus->iommu_opaqu=
e,
+                                                    devfn, pasid, notifier=
);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
+void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->pri_unregister_notifier) {
+        iommu_bus->iommu_ops->pri_unregister_notifier(bus,
+                                                      iommu_bus->iommu_opa=
que,
+                                                      devfn, pasid);
+    }
+}
+
 ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
                                     bool priv_req, bool exec_req,
                                     hwaddr addr, size_t length,
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5d72607ed5..a6854dad2b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -375,6 +375,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
=20
 void pci_device_deassert_intx(PCIDevice *dev);
=20
+/* Page Request Interface */
+typedef enum {
+    IOMMU_PRI_RESP_SUCCESS,
+    IOMMU_PRI_RESP_INVALID_REQUEST,
+    IOMMU_PRI_RESP_FAILURE,
+} IOMMUPRIResponseCode;
+
+typedef struct IOMMUPRIResponse {
+    IOMMUPRIResponseCode response_code;
+    uint16_t prgi;
+} IOMMUPRIResponse;
+
+struct IOMMUPRINotifier;
+
+typedef void (*IOMMUPRINotify)(struct IOMMUPRINotifier *notifier,
+                               IOMMUPRIResponse *response);
+
+typedef struct IOMMUPRINotifier {
+    IOMMUPRINotify notify;
+} IOMMUPRINotifier;
+
+#define PCI_PRI_PRGI_MASK 0x1ffU
=20
 /**
  * struct PCIIOMMUOps: callbacks structure for specific IOMMU handlers
@@ -536,6 +558,72 @@ typedef struct PCIIOMMUOps {
                                        IOMMUTLBEntry *result,
                                        size_t result_length,
                                        uint32_t *err_count);
+    /**
+     * @pri_register_notifier: setup the PRI completion callback.
+     *
+     * Callback required if devices are allowed to use the page request
+     * interface.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to track.
+     *
+     * @notifier: the notifier to register.
+     */
+    void (*pri_register_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                  uint32_t pasid, IOMMUPRINotifier *notifi=
er);
+    /**
+     * @pri_unregister_notifier: remove the PRI completion callback.
+     *
+     * Callback required if devices are allowed to use the page request
+     * interface.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to stop tracking.
+     */
+    void (*pri_unregister_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                    uint32_t pasid);
+    /**
+     * @pri_request_page: issue a PRI request.
+     *
+     * Callback required if devices are allowed to use the page request
+     * interface.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to use for the request.
+     *
+     * @priv_req: privileged mode bit (PASID TLP).
+     *
+     * @exec_req: execute request bit (PASID TLP).
+     *
+     * @addr: untranslated address of the requested page.
+     *
+     * @lpig: last page in group.
+     *
+     * @prgi: page request group index.
+     *
+     * @is_read: request read access.
+     *
+     * @is_write: request write access.
+     */
+    int (*pri_request_page)(PCIBus *bus, void *opaque, int devfn,
+                            uint32_t pasid, bool priv_req, bool exec_req,
+                            hwaddr addr, bool lpig, uint16_t prgi, bool is=
_read,
+                            bool is_write);
 } PCIIOMMUOps;
=20
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -595,6 +683,48 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, ui=
nt32_t pasid,
                                     size_t result_length,
                                     uint32_t *err_count);
=20
+/**
+ * pci_pri_request_page: perform a PRI request.
+ *
+ * Returns 0 if the PRI request has been sent to the guest OS,
+ * an error code otherwise.
+ *
+ * @dev: the PRI-capable PCI device.
+ * @pasid: the pasid of the address space in which the translation will be=
 done.
+ * @priv_req: privileged mode bit (PASID TLP).
+ * @exec_req: execute request bit (PASID TLP).
+ * @addr: untranslated address of the requested page.
+ * @lpig: last page in group.
+ * @prgi: page request group index.
+ * @is_read: request read access.
+ * @is_write: request write access.
+ */
+int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
+                         bool exec_req, hwaddr addr, bool lpig,
+                         uint16_t prgi, bool is_read, bool is_write);
+
+/**
+ * pci_pri_register_notifier: register the PRI callback for a given addres=
s
+ * space.
+ *
+ * Returns 0 on success, an error code otherwise.
+ *
+ * @dev: the PRI-capable PCI device.
+ * @pasid: the pasid of the address space to track.
+ * @notifier: the notifier to register.
+ */
+int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
+                              IOMMUPRINotifier *notifier);
+
+/**
+ * pci_pri_unregister_notifier: remove the PRI callback from a given addre=
ss
+ * space.
+ *
+ * @dev: the PRI-capable PCI device.
+ * @pasid: the pasid of the address space to stop tracking.
+ */
+void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid);
+
 /**
  * pci_iommu_register_iotlb_notifier: register a notifier for changes to
  * IOMMU translation entries in a specific address space.
--=20
2.49.0

