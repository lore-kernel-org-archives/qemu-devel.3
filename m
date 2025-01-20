Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1FCC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvml-0004vY-5c; Mon, 20 Jan 2025 12:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmg-0004jF-PP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:58 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvme-0000bO-NE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394916; x=1768930916;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hS+ubrQMFsIzNpAi8WQb/IPQKIWvAB02nNA7fqJhrm8=;
 b=u+JCSzJJjlNSHViL9atfL33bXCglLZyGXV66k1SukLtIjcPtENkpqc8s
 Q6F60/l5ry5b+5U+cmqunrRddU6Tv9TA2Iun0ZU1Q/dfbA14XAwRnzPxo
 US3gYL99Uj9vc85uALSsbFyaCgC7hz0wrhzO5yHdTtICRL4PYLpUawfw/
 xZydDzAoT3+Ci704v6/wfJF16zF54o2PJx13g8aYbcMVsL0RykWohO4BY
 VixDGzZtjyD7vtC6ZXuP/sOmpYuF25IaPIYaRiP53x8NHwrya6rbBmoDk
 UVuMaQKT0luFYp1oxlGkv1Pjq8DTeFRx7pFBYJZ6DCTiSeRiYf0UQ/3CW w==;
X-CSE-ConnectionGUID: TUUnE5xnSkCQwBYtOhr/fw==
X-CSE-MsgGUID: I+QRl/JoTGO/N+VPov5Bwg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29133404"
X-MGA-submission: =?us-ascii?q?MDEf8bepAENXnAdZCGtLsxUOXsrupHjthICIND?=
 =?us-ascii?q?hJ6f4/YzxG4W5vrhaAm4mG384pd0rf5p82MsrUdPii0AQs4mX4GNKC5r?=
 =?us-ascii?q?+WxKWv7heq25R8QFgyZ+Wfm82Xqnf8MGR68ItsbSMiOuj1gbb67H6W3z?=
 =?us-ascii?q?VBt5HjN+VcY4T73Pe2Axz8iw=3D=3D?=
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.113])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW1KUV/nxFleGQsXGECz59AzBFSUN1ZY+tqj4xNnOEej52xyqZybv0cW1EHHxLPgnt7PqxWKB9F6itWZQcvRcDib0//qxcA8Ty46DwlKg+nnXwp1jLNpCgpplLqbKSgMHgmaJ5WMPDVGTQYD/SGQJBmNzBViOfUq2PLHCygJvftw6iYJAkNrU9w0qa4VhMMvoviG2lFSp27Q5m+kIYmrWvJHJv/yGtSZHQwnlaVtY38LcirSdtTb2Z8dvAcMT3y4B3dXJRv9ClYH+A1HW8j4OmegfRoFiW9afAXr5Kk0JmZxeI+dDjCCgfZRO2XXErLEJgl8T73tQyXhp9ndroPE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOf2f5rIkqvUHqqQnX73Mt6rzDe2WT3VgsfOVe4zjtA=;
 b=C6zhInCcKvD0hHY+nkzfLRwSn+4q8ZE1y59zW27KW8AielqZe/CuPC+7X4WIk/gTXZOch5sifVgyyEkWmywOpvPvhKeDmgYKWqmuxI1//0FHFgXsR5142JudwbHhm8oQ5+Z5C4F/wMh/czYEEHXylKRLPYfHC03zKtY9fdZPgdu5f53/iB67lBcLBNGDoCaWISXhk95GyUXgXoo0VQDMshleEJQzWvEPGPijw5QV4gJbcjISADDPcgFFkFmmje53aLMMiGXgj7Pyq20IcCVfGzTqZLHC0GehpZiSBowIXWjJD2OHqa24kqutdWE0hnXqTbYXqbx2O7giYjNqhQgpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOf2f5rIkqvUHqqQnX73Mt6rzDe2WT3VgsfOVe4zjtA=;
 b=L/GfRFjvNWwF+smwD/UIhCCmbgFdydQBywmn7lXSf3W75sre0JdCBp7+RGYyfoS0mkw8yqoRnCuTgkWzqCLjC/Hk4NmwSQmvEPx9y5HwVhSGKXCOIR+PsxS+gx6/CL6+iQeVcS6+KHkRiZrbYP4ZOb2472dLuU84xQs8q7jEBQgljiDPdottlOxONoOjQdRDLHoOlc7p0hAP+oHujqSI6xyrBpHisCPENr5uDAwdrS+mvVMCiq0Fvqy9PHXkNMLsWjU3JU6SUvNnmGBPoRx+8Q++uZ8KMOIUIXI2KIxr+JeaGO5rz3jZ6hFkS+G1sOx3zlEQl12LtHLgstDbTGIEOg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 15/19] memory: Add an API for ATS support
Thread-Topic: [PATCH v2 15/19] memory: Add an API for ATS support
Thread-Index: AQHba2KYusTOf31TZkq7lrpG5ZaiWA==
Date: Mon, 20 Jan 2025 17:41:53 +0000
Message-ID: <20250120174033.308518-16-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: da147a44-d56b-49a6-d08d-08dd3979ba8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BtJrSx9h+6TFlEx+9MWXlF/bzHE+CAfEVxL/yRB8vKoJdiLv8JR+Nh0lh4?=
 =?iso-8859-1?Q?v6Q7Zga8JIV2qazRzshonDp0W6DyKVPOZ+h4/iIZVu82pnwe5eXkugpBaP?=
 =?iso-8859-1?Q?q6ElDUiBaEzam47LkkRa7hhZ5tdoFwr+nxoRQLMRL2cYGlLlEs2n3O4y5H?=
 =?iso-8859-1?Q?VdK69g88SRQDjjd0q9xW1Xx+VaSTWr2TXaoAeo3AysSPQXPNJ1wQc6I3mb?=
 =?iso-8859-1?Q?R0R+6lwz6YoILcTw1b+3MG9adJ+/NtLmn2gmNJhVYRu7Z8nifL4rifJQ8D?=
 =?iso-8859-1?Q?mTZooSOPJ1EhljKUq7ZTnFOI1FCIb+3rMyQeAn5KWBqvFUq/sDGUpGGppW?=
 =?iso-8859-1?Q?8MMBUUuXuzAU+pUM1Q4bDLtOUeHc1C9ZlwzGu0+y4OOq8UuyWmLCyE4GQU?=
 =?iso-8859-1?Q?sySJNd99kFXd9Xo52KcWC5rTZJQPEPPhAfFLOMqRaGdsv+SGOCa734IV1J?=
 =?iso-8859-1?Q?joWZUAhG1bIe1EQ1zegVPnkN4+sIqTmL/5PuSBsVjpbwLSPyeY3n4EmLzB?=
 =?iso-8859-1?Q?YbbUbRaHs1BYFtaG4QL1hi91Xv+JfALBwUwXGdnn7SQAaJzsK9cMq3B2EV?=
 =?iso-8859-1?Q?24C9FNStsOC17tCVKgKhRM3sC0Vzx4Kqsqf+gsLnAlyjNbX9DPgpJMLSyz?=
 =?iso-8859-1?Q?tYimyCAlhvDci7G6ZOgTNMuiT6O1HaPO60BOdn7ohgSd8cWcyXbFf4UdV/?=
 =?iso-8859-1?Q?lKnHSFoy2ZuU9fFB1vDHhNMbgv+tjHaGPSl8ZJiKhIxKi+MDpOdmdgUCDY?=
 =?iso-8859-1?Q?J7VwGM+mBAuqXwt4YzxXIWkuyYjB+DNMObZ8WyBjB7++21G0mSCj1H9nT5?=
 =?iso-8859-1?Q?tD0U90BzMS2O6nDv4g024j+2i93PMiZoqgfHIFt5qYovxenWdp182nDGpF?=
 =?iso-8859-1?Q?edV/dD5WEg0xf7Ga26shId4OuPdsbrPLVMT686H1+3GeE2mQxzRzvT2GYb?=
 =?iso-8859-1?Q?RdJjkiqd/JJdFI9PqQdKTdig79PYDyKKyE6uR/xZSV1cdXkhkG0qD1oCiB?=
 =?iso-8859-1?Q?CbGfYukpit8Tl0BXfNM6vUcqIR2YYYqNcvkfbkNRO34TSme40vX4o1QBZa?=
 =?iso-8859-1?Q?qQ9RopwGnVPzoM6HHrGc8k80V/B7Z7ONNmSTNpoLrExzsruusREE+UKKZt?=
 =?iso-8859-1?Q?fxZ2UoQ+dt7/+RshORiVQz+mL2jHzSXbzDra3oHLYNpHxM4wpdxo4hb7Fm?=
 =?iso-8859-1?Q?cGvoA9qP5uR4B8wG6mva+cT7BMWon+jgl92iRlux0HRDY4UjRKcHJ7Z9pp?=
 =?iso-8859-1?Q?4N8bY8RTLm4iCGN0Y8Qg/KJkG8y6B/Ht7dG5RnlYkw/YZyOPRMkm67A3Ox?=
 =?iso-8859-1?Q?ZcXqLF3+FKk4XSF0s2uM4APetYJJXZEAQukh20EpUpp8OKEvOyMoguPEHE?=
 =?iso-8859-1?Q?LFFMWltQHpW+NMwExUmsjGpCVfv/w9TtxPTqZM0PTxfLfQF/GXn9FyMyJU?=
 =?iso-8859-1?Q?vON9D8qx+4RavBW5jwDydSY6Ja08kp7FcrOsTA9GfHqmbpiR7O32goM1+q?=
 =?iso-8859-1?Q?DUyxIL+PSkw+YTitzrQJv5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VvFJLeHCpl3hkzgaMqoskqsXMJjUWJvGofX4+WwyWK+uqt0Ebxy8+wPzVW?=
 =?iso-8859-1?Q?+zhryNMFrA+oQFvFuj7P4L3PMktpLe9G9nGtoo5+Y5TbPZu3XuvkIlK1xg?=
 =?iso-8859-1?Q?S/MX14sKccTiDNu9eHlqW48QHqzUEq19mC8RqiNSjIirZLIKv/e+cqqzad?=
 =?iso-8859-1?Q?AE4+eAmlO74LCuUPG/Xs7H6OKgwcUQF2Mn2jEERceaVN0E9DSO33L5fdAd?=
 =?iso-8859-1?Q?guW4I+ZNXN/WCbTgPsFmVyiu2MrmU4k/ebMr4kIAihVy0cDbmcL5FHQRAx?=
 =?iso-8859-1?Q?mMwnNHh9FzSOpmKViTwY20RLuahR0KL+v7FAgS3rwZfJQle7cFWdG4t34j?=
 =?iso-8859-1?Q?Nx9rz2tkshro/PwW9Ytljz0IpMy1ZApbhWy69GF7GzcTPBGuSxuozTpJrV?=
 =?iso-8859-1?Q?tDmlQ9NLuf655tPThEjcwuLzLjef9PH6tooomoYyd+rDRfC7v+bmRjNxeW?=
 =?iso-8859-1?Q?VSeWC/CkahzcW8fKszZZrjbSnNOFOsEFGgqEubksP+WFyKYct54V38XpVq?=
 =?iso-8859-1?Q?0MIx+fZ3jvSwZRIbWRHMNj7G9NStc+XzI6GpFkqdLvXbw9i8iWGenHVzo5?=
 =?iso-8859-1?Q?uRieIKi0eoHy4DxK9GJ3SXgxcE6e7wpR4LlpolxE0djOTXfjX4brLQjqjI?=
 =?iso-8859-1?Q?Ju5aa9PDABIpglGt9CZdrYVH9VO3idk1ZjkYTiSiJfwsaJCDGf3rbmoD29?=
 =?iso-8859-1?Q?GqtK00Vw4jGmenhb018R17PxTUXAbF+jA3ewPJ79Fb1TkgOOB0d5YwrxlB?=
 =?iso-8859-1?Q?UsIbCSgH3RLqGk/ZBv1SDcKDAcBFULi1R6qylNIzPhgIlP3hk++DEWQcYX?=
 =?iso-8859-1?Q?tL7OwB+e+a1BL5942r8Lm5MjZOCQ2OQFjkXzfCDntrI7iOXFWinJa/HXCb?=
 =?iso-8859-1?Q?teOMfjwDBIcwM44BDynUQvL9qeC+9raUPmtXUPDAwMNi7ppXhAIVf/rest?=
 =?iso-8859-1?Q?QJ4SJrmMslYUMEBogXXRCD+a07TP/Sj1c0f6QGpk3YQh8+ByB9RuLGv3dF?=
 =?iso-8859-1?Q?jCUReIHCiR7ZGWSdJ/AEtuLauMZh58BtJWUpaV7zxZtOS9wX8S5WjgmcfG?=
 =?iso-8859-1?Q?O9/Pe89KilObx2NbIbgQCZacJSyK1+kmwlc8jDGKWOYUMrrz9nC7xRTw7t?=
 =?iso-8859-1?Q?Adqvl1Bj/VwhJIl3vpRpZMJUl7POnUmvWa8Jw4wMv+JbDcCchJusg4u0XH?=
 =?iso-8859-1?Q?PVDVK66WQAq5AOsaqg+9BRbDcpQuQd+2lxi43M8Tj+E58AdzAT4ckJSQ5h?=
 =?iso-8859-1?Q?A8FJR2kXU1gJ9bsIFUBxs10nlA8NN6BjWcmX55iON08c8iT2+CL38KH8Eo?=
 =?iso-8859-1?Q?D75QFk92/+vXumJTGlG00v+OHvG/AJ8bAqu3lm+NYng79xQjDxfxwMoq0/?=
 =?iso-8859-1?Q?zKIiSNC+LgAumd7xLFfQa7hA3mrY35O5e1fxwkOSrsMPZ/vgtJN+xWYe88?=
 =?iso-8859-1?Q?0Vz6H35yJciy5jMcwM9yRtUtkG9AmFD8yGYo6X5ieQkc6GKWZx6VodVkBK?=
 =?iso-8859-1?Q?cZl/jWCZYdlTsLXA1p7QF0FqBt7SWCNVWU3nqMiCekZ+kTran6JOg4zB/W?=
 =?iso-8859-1?Q?St967Ejs+azrDWp2vOEdPU5L8n6o1EuzLmhiJnKGZpVx1AtDBYxTi213Os?=
 =?iso-8859-1?Q?tyd5B49+SxV2p8mB9TxQ3n55U8FBEvFAby0OTxi4FVGLHjIAzaONOKY4Pb?=
 =?iso-8859-1?Q?dehNPvYBLbqpjQ6j5kk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da147a44-d56b-49a6-d08d-08dd3979ba8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:53.9779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrVysPfP8wFrd1S1JT/uHNItUPDQeSnCZYiFnSJcPVRnTqM30Oq7wkMJ+3+AlRmnjkjfq6Zgp86ClYAJOGgx7bxxOXEmZAlrfeaVivNWCFuF2RSazBwIxSwN/BPLBlQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.036, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

IOMMU have to implement iommu_ats_request_translation to support ATS.

Devices can use IOMMU_TLB_ENTRY_TRANSLATION_ERROR to check the tlb
entries returned by a translation request.

We decided not to use the existing translation operation for 2 reasons.
First, ATS is designed to translate ranges and not isolated addresses.
Second, we need ATS-specific parameters.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 26 ++++++++++++++++++++++++++
 system/memory.c       | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 468b003bf1..042d4ea5be 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -148,6 +148,10 @@ struct IOMMUTLBEntry {
     uint32_t         pasid;
 };
=20
+/* Check if an IOMMU TLB entry indicates a translation error */
+#define IOMMU_TLB_ENTRY_TRANSLATION_ERROR(entry) ((((entry)->perm) & IOMMU=
_RW) \
+                                                    =3D=3D IOMMU_NONE)
+
 /*
  * Bitmap for different IOMMUNotifier capabilities. Each notifier can
  * register with one or multiple IOMMU Notifier capability bit(s).
@@ -525,6 +529,20 @@ struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /**
+     * @iommu_ats_request_translation:
+     * This method must be implemented if the IOMMU has ATS enabled
+     *
+     * @see pci_ats_request_translation_pasid
+     */
+    ssize_t (*iommu_ats_request_translation)(IOMMUMemoryRegion *iommu,
+                                             bool priv_req, bool exec_req,
+                                             hwaddr addr, size_t length,
+                                             bool no_write,
+                                             IOMMUTLBEntry *result,
+                                             size_t result_length,
+                                             uint32_t *err_count);
 };
=20
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1882,6 +1900,14 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *i=
ommu_mr, IOMMUNotifier *n);
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n);
=20
+ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iom=
mu_mr,
+                                                bool priv_req, bool exec_r=
eq,
+                                                hwaddr addr, size_t length=
,
+                                                bool no_write,
+                                                IOMMUTLBEntry *result,
+                                                size_t result_length,
+                                                uint32_t *err_count);
+
 /**
  * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
  * defined on the IOMMU.
diff --git a/system/memory.c b/system/memory.c
index b17b5538ff..0a379a72bb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2011,6 +2011,27 @@ void memory_region_unregister_iommu_notifier(MemoryR=
egion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr, NULL);
 }
=20
+ssize_t memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iom=
mu_mr,
+                                                    bool priv_req,
+                                                    bool exec_req,
+                                                    hwaddr addr, size_t le=
ngth,
+                                                    bool no_write,
+                                                    IOMMUTLBEntry *result,
+                                                    size_t result_length,
+                                                    uint32_t *err_count)
+{
+    IOMMUMemoryRegionClass *imrc =3D
+        memory_region_get_iommu_class_nocheck(iommu_mr);
+
+    if (!imrc->iommu_ats_request_translation) {
+        return -ENODEV;
+    }
+
+    return imrc->iommu_ats_request_translation(iommu_mr, priv_req, exec_re=
q,
+                                               addr, length, no_write, res=
ult,
+                                               result_length, err_count);
+}
+
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
                                     const IOMMUTLBEvent *event)
 {
--=20
2.47.1

