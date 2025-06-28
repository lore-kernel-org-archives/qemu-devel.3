Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645F5C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 18:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVZuN-0006Ez-5W; Sat, 28 Jun 2025 14:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuL-0006E9-Ll
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:09 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uVZuJ-0004AS-Rw
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 14:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1751133847; x=1782669847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XtZQcAErf00KxKL/K9Kvau6J/cz2YRkvXNggZparffo=;
 b=dbPMdC6BYfpbZGcNb5HSWP/1jupJI1TK6h5JB1N+RK+Ne2AvzIZ1Vn5a
 LkSYFcTTm0l252ZXq5ReJM2c0hb2ngA+kpB0AXaSeu7FnxpPX7hMs2MFB
 dcwduzdUlS1Oy6jbmjP66DQzs3SoOr49lu6Tgrbfv6twp46aJGJMXNkPW
 ZmxLJekVvX9MDXG+ajJR/RqOJOMrRKmn4Hu1dXGDUZgwX/5K538Ieyb67
 UdGhJxOEp9GhFX/2O2unQT4fd0Tnuwxm0KgKvyz2d9Ud03dzRWBFCc7M6
 YVTR4FJGxRn5MxH/xCnCjifPqjE6xFu6UB/A1SbOB9XWw7hWMrNbxylZa g==;
X-CSE-ConnectionGUID: KcUAvee0Q9+frpliQ2oX+g==
X-CSE-MsgGUID: DzUfxunQQVi1ElvTCIgZGw==
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; d="scan'208";a="39512597"
X-MGA-submission: =?us-ascii?q?MDFTOdAsctlTapFnsow+Ylt6WjTapqAc5Zx+tK?=
 =?us-ascii?q?UeM7qo2B+edMo3N6P/MQceyWFbe7Rq5DS4VNLmt2wreYUCQ/K/jeRhWJ?=
 =?us-ascii?q?aPWGlD3rpbLmNFgLFIj08krOTAl5gfLXh0F3IYIrjQAUoRtOK/YJzlnm?=
 =?us-ascii?q?gJfCrg29l/hxsn5SxDxvlotA=3D=3D?=
Received: from mail-francesouthazon11011001.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.1])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Jun 2025 20:04:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR9ZfNRm8u1lGmTpuJqpAzyzc0KIgccCb3Z4e3h8OohioXIrYDlgkjIy5GiJaqHuoPHEHnonQnFA6aGERQlYwEZTSUedrDoR8ov66nb4/UbwYmieYsRAGBtrjgXNGQvKrpaJeZA0cwm+i5SmbcxF+fxwGGvlgVcfI9OV1XuutqmeJlQF48lqLxnRhJeVm5KtUAlb3gLA3H3ppPJOGn2awaa1ZX/XLavLZqMTnM7EN8OeXIyOkM9ovBx5vxRQSIdoN7ObrKkacFo5qtTlrESRATsF7szRkfVkN+BhPdwrZVStN/9f7ZPzfe71MDBDx+uLEKkjUmbaBfOPyMVLDziCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euWKsQmXuf1eWPsQq9wfHMFo66RInKDcenhDAqRaz6o=;
 b=uAj3IZnI8t+y/gQvDeclazesHOdyAqSnHr6HRSEcvf7BVq8vB7J8DPgsj3qvD1EHTt8vh/puIDmjhO5dv5roqWP/uTf4QYIl/FafMDSQ3akvCdQHcxe9qFgnRv7Ot+rJRrjK5DuGft8gbgNhvHOO3sAv2yI/h/waxyQsAuyG43/GRERVMuZbXDU+zwg0m5I1FkwT5l8+vjbzysFjalph6pRhvN78Uk+Wi2JtDPvBMy/Caw6WGIgl1vzi1YW14RWxxWF9WYyYqGFMnbNRQlVwZBGtX4vj6MeZ/KL6CVRQIHHHd0mzIoYVJJyDkVN2Yj+5ECSs4TPE3sNF4CdKexnTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euWKsQmXuf1eWPsQq9wfHMFo66RInKDcenhDAqRaz6o=;
 b=c+qP+1ulsEIMFvgEfaSwdBI+TRG6vSNmoEfy8bY6m34gNC3WOnS8Ih23/hZ1WngvG4G+e2gajd1nPw6JhgOodZfimqTIyGJkIyl7qWS1JI7IuYuStaXNLVUQZwm3VaPEG7vHYlJab6CgCUBe08Af4hudPolO8Z/kRcdDzR+yHJaLXqyds9wUjDFMcgNg0Z8YAciqkUhWLbg2H+74wx9BlkdVt4usDrkoz7+UJl/G0l7pKQY+2k+pRKqIYDLIDt90kUSwxGiUGEGot6uoQiCiRjA6erZmAR8S77rhcKlNbKtyxcCNAXeFD6AbYjeEP1VlnUCRtHn78sI9Mb98Yt0UhQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB5PR07MB10238.eurprd07.prod.outlook.com (2603:10a6:10:5e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 18:04:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 18:04:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>, Ethan MILON <ethan.milon@eviden.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 05/10] intel_iommu: Declare supported PASID size
Thread-Topic: [PATCH 05/10] intel_iommu: Declare supported PASID size
Thread-Index: AQHb6FcIvDq6J9qjnEaopN6S0Y4N2g==
Date: Sat, 28 Jun 2025 18:04:03 +0000
Message-ID: <20250628180226.133285-6-clement.mathieu--drif@eviden.com>
References: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250628180226.133285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB5PR07MB10238:EE_
x-ms-office365-filtering-correlation-id: daf806a8-9326-453d-defb-08ddb66e2ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BIotJLWWSl16hEOfqdqWzl15/ohqMMGHLVKl89J8nR8A1KdjelFUrWv2mQ?=
 =?iso-8859-1?Q?p10JHlnv4iPm5dSsIWdfxxDdA5INdo+M3JdBpLz2vT1sbl/S1NGFTLenQt?=
 =?iso-8859-1?Q?0oCzQxLvkf0TWDQ1iV+KTe8+dk1F4vDwfON6l3UXdoeVRFzTM4rRPxOjaX?=
 =?iso-8859-1?Q?+yXBFnAi2sJbO/nR5EWeS7g26ZU1PDhe6ROzeJj5nBdy43y7uDFr8Nolnr?=
 =?iso-8859-1?Q?ovEb52W4w/arkEGWMnUifBOLK44XlQF1miXETNHgaDud2Dt1KqDDLOG7U/?=
 =?iso-8859-1?Q?ct8cM5qURlUyi7fC1oGzUCJzqrN7Q5H25QT0DywK6FjUwaW5anP3r6jzck?=
 =?iso-8859-1?Q?lxadIo5q7kjfy8A9rtlHgEhPENqJodu1Hb0JqMOZWEDwIk3OPUfrixp4mP?=
 =?iso-8859-1?Q?jkoYUeNIoAcHH5ubiNT2zDVtzgzFGWLsFt8Gc1fxtklLJ1omWM4mgijmzx?=
 =?iso-8859-1?Q?JL6Tr93XFuVkbH1LhSSbNhDGH9kYkBJAUnwNxlqppzaXiEGsMAdPyeQkv9?=
 =?iso-8859-1?Q?GWSkDWer0j7KpucLnbcCBLKG1LrbFeeiloIATn7QVhGkiPmeiGrHdcR76G?=
 =?iso-8859-1?Q?cYG2OEbKb7HMynHUsTuaAI3RW3ecXlLiQlsp9qwK6LGELRqoYh3Tz+5AFA?=
 =?iso-8859-1?Q?sb0ZwyfsJ73VfG+cHHj2cQdTc6jlKkhCK1sAbCVHP6EHwfFViP31L/aVDz?=
 =?iso-8859-1?Q?QTecP3AsiCEoU2xiBYa8n9YWnRCglPpWQe22xfWkR16mg83OA1dM9fW+Z6?=
 =?iso-8859-1?Q?yDenmw2B0FLrONgQTwCkiUu44g3bGg6VxJWCb6NUmD9gXLMDBGIYaSD295?=
 =?iso-8859-1?Q?dkxFOSzWuKUWPbsRpkv9q3Q6itFpDaoYmmU7WIpMGfpiUV7LF1zMYa9pkq?=
 =?iso-8859-1?Q?+xfz8+naASHfr8AHNq/JI6esD0FWjGNIcxGg1+aKNaK+Z3aoxc0tVetcCN?=
 =?iso-8859-1?Q?FVweH6NUoetCgONakFidQ7cCx4S1uZF1T1bZhsFXBm5j5d40Yuq3wucu4b?=
 =?iso-8859-1?Q?Lr1HnMxsIvpBecPVJXDRb7wTVCvWXnBXqEH6uNWRV9aFSm6xi8rbbU8NCn?=
 =?iso-8859-1?Q?4a0AjGCDZ3YLy7VAvs9Z/z6uNdKlyEYPUfoNp1AHSNlzh6UDLZYKW2zRgM?=
 =?iso-8859-1?Q?T/VDXypNDKnzhXFNMQSekVmIE6krjSOJ5ionMw1yPVR3ShAREoY2bVwBrK?=
 =?iso-8859-1?Q?r7p1boYoAbpQgooXBayr6EV9LL0TVAksuUkjAeXJWzeI0GXmhYmWUaCMty?=
 =?iso-8859-1?Q?4p2r/AbpTXSBPGy9W26jFIOVg9p+BjeIGKIStXeYHQXcBlQKEtF9A/JPUM?=
 =?iso-8859-1?Q?AWgZMNcpSrBpmYqFXIRd3SKa5wxa8lzMh7tLEYShs+cQCz3arvEUDAGons?=
 =?iso-8859-1?Q?AGmY10zM0WNFLJC0R/c3+h5BGR+yjgcFO4/akQg4JXRkT0F6fvXGO0LoEB?=
 =?iso-8859-1?Q?8ZCeMIbeZ1Knpi9k5qipUsO8DNC4q1W8nSEY3hiMtnYHqxW3Qx71EARXRk?=
 =?iso-8859-1?Q?hcaRiXZgO8fPGZbjYW6ll2mkx2T6qziAQwcsaGp1WkYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gc+THLFLLcsJGRvjOxqCsvQS2Pdqnf16jTU1lTYTxNOEstPiyyDNDmcRha?=
 =?iso-8859-1?Q?/U+rv/MVKnqXq37cBCDTQy7rCopoD3m80XbpZOxhEceKpfhQKoRN7C0J8I?=
 =?iso-8859-1?Q?hG2JwWuOb9/gjtqzB1dCJWruUPjIamzYB+a+xiuW+c9XXo7GeOrxmpct3N?=
 =?iso-8859-1?Q?KjCpqASi9U4wmYstyEyLM0QAKIinN8wm0dnbC6+s7U5/lbprKSpce9xq/Q?=
 =?iso-8859-1?Q?XbdezKJAW/3yXjmnwrcRTBKa/wIUGaBWrIhPLhSlJT0uion1pkkL+rMyvk?=
 =?iso-8859-1?Q?e5CdKB7uRaFAp3OuR/A2EnFoRSUB7Ak802U6Nj8wqH56SVsbtLqwUbGYrE?=
 =?iso-8859-1?Q?nJTbpqryYQAAliQpxc37Zd2OE2eEps7yq23LiPpUyu1x9iStlbG0pSC5qT?=
 =?iso-8859-1?Q?2kNYXuJ6uVP5yqvfGQWLJsTu4XxT62/BDyqJB1GAEFManuUu5wL0wEALsN?=
 =?iso-8859-1?Q?a94lXcqS3oFfl8blx8gaHWXM5hLWVbWzjkOBrOM2onRsp602o5SJ1qocWo?=
 =?iso-8859-1?Q?CXXUPMjmCEg9mAlHhyId+A42+ugX2GG1UkJE506QmVDa4QIpRf4M8YQJzy?=
 =?iso-8859-1?Q?ibwfE05LS6/ReXwgD7Zq/WGHzODyoAY3pIoLMDu7hs4kFPNSvFxBCjP1ah?=
 =?iso-8859-1?Q?HUbJXg0QObknYvdLSgCWpNfKoT5P6x3Ds0aKdHsPs8DFLQyvFlRWWR7WKU?=
 =?iso-8859-1?Q?O7HJiMUVcBHA/ac1WR9HXqN6MMWqwoJMH3Eji3gz/wWCP7iheYzqF8/9MW?=
 =?iso-8859-1?Q?C1BnvVczX1mkAhmmveAi++s8PiILJ0VZfvHdrHRjctw6vOjH2d1JdwgBdy?=
 =?iso-8859-1?Q?GnrtyuZ5NlP9djM2H1cVMmZjyEtEUaBJZgEHfiU/WdG5EMRzPzOLcosu1n?=
 =?iso-8859-1?Q?fEWSelXjJKli6F5Rr/zLp2tK1pJtV/ExwRk4IYT0jEj6gP1TEYMGNYH/0n?=
 =?iso-8859-1?Q?MbUgFDKAzxTs/LDcjXZNKFoFjK3H09f12zt1Zv8EKCt6wmDBM6wDIPmSgx?=
 =?iso-8859-1?Q?wh3v2FJdyb5J8HXaZed+TnIRgsBvosRCCQyvOrzt5+Nzw+EUzcGfpUcN+f?=
 =?iso-8859-1?Q?8XAAfw19PhpvRK5N2+iO1MAixNkMPKdS9KAEOssOz+YfK4P3f9zH/LQnXH?=
 =?iso-8859-1?Q?x7naGuP+6w3LSOMSfC7RndWk8a94rLO+cbgovL90aH0wkUGKZSoqUVnTa/?=
 =?iso-8859-1?Q?I/2Cio6f3zOAQZ10fnriIgoUEizbCbpp3b2kJAqATPgCPBxNhO9zqkgXsN?=
 =?iso-8859-1?Q?ShbVel9tlHA/d2DdfDwcpjb+Dey/Vt/Or3BqyAxboTy4Shpi3Vp8nbao7D?=
 =?iso-8859-1?Q?PSWc6S3Gzjm4rwRmj/fGs1RgP2evTc691qashyIPahOhrEnuriD2u/CvO1?=
 =?iso-8859-1?Q?DaMVeYo0AQaXinfhZp/knQh4eRTqgRc7Y4YMry3vBqDK2dXsrln/acxZhE?=
 =?iso-8859-1?Q?Yb+N8ojV3nHhaBlxfWIkkIlRea5HHdkf87CqS6CiSC2LIwjxHYKXyvWGIK?=
 =?iso-8859-1?Q?WPzeD0MWm2Gx1SO7L8o82j4Oqgse5XTqeZP/sV8K5s+FKO5fCRqdFkEY9N?=
 =?iso-8859-1?Q?2a0dEv67IR2ZnS835eM0oLIBbsUzlobgjweLu/FaCvs/k75j17D/N5/27I?=
 =?iso-8859-1?Q?EZjKJKYp6SZbGrwgTQjm6B5ktVzvC7xtC3/ClJWVoOcVA3pn6Jc3UR+O2P?=
 =?iso-8859-1?Q?U+DmHBMntOs7CNPSMZQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf806a8-9326-453d-defb-08ddb66e2ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 18:04:03.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huwem/XOYBSA8O18kPdQA/vE6zmiMYCracMu6LBQP2vN1ZZ4JyutSisg6Zuqv6mSuvf9QK02ZJEt0RmCTmSOY9e859FT98YX/OqoJPAfJDuXUuLZOrofizAGUEjV0siS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB10238
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

the PSS field of the extended capabilities stores the supported PASID
size minus 1. This commit adds support for 8bits PASIDs (limited by
MemTxAttrs::pid).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 2 +-
 hw/i386/intel_iommu_internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0fb4350d48..71497f1936 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4590,7 +4590,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
=20
     if (s->pasid) {
-        s->ecap |=3D VTD_ECAP_PASID;
+        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
     }
 }
=20
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e8b211e8b0..360e937989 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid=
 */
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
--=20
2.49.0

