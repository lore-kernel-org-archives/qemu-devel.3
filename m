Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6876C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFo-00019y-C0; Tue, 20 May 2025 03:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFm-000198-9u
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:10 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFi-00027n-Mt
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725547; x=1779261547;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=guVsT7eOG7yNmgi4x5fNqYuhhS1067AvzcSP7XFDAb4=;
 b=Yq44Jf2M6PJZKtlNu4TvdRwru14c7kKTSq+Yha0f5AY5joJpCPoIDXwu
 mjhnJd2wMR+G+Or8lOmLhZ7/XY7xj8FfCWHq1jhgGcQYLQbzftfESxRlv
 npt4HLFBnZW5A32jp86mrboR2y+8lga4Nf/tHNBw1ImacHLoUPS+M8jJi
 p4ZumS3A2obAUymPQszXP2qhrgGu28zkbp3cackICXaf2TBTIEsZ6BuVc
 R93bLRVgizEZObSxWmr9nb3BsZeQ325Ti7e3MFNo2Stg7jENnSntFc+a6
 tGpgfAKPMo6Fb2uP0R0Mtlchrmou9NEQS+89AWV6kffVtkVjWOPECFpIF Q==;
X-CSE-ConnectionGUID: eLtyC3XsTp+eoSuc/AlEGQ==
X-CSE-MsgGUID: kIC7/IINTd+C1yP97w994g==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37191610"
X-MGA-submission: =?us-ascii?q?MDF35LrAw1eDkExWspk5Cpir0tSNgMwtaFY6Jv?=
 =?us-ascii?q?SJ+yulkCyip+CxbTE8smPpq1WqyXvKT1KMsD9mZjGSA9DPkgKPP68JOD?=
 =?us-ascii?q?W/oAM7g7akoMaDadbZNzsA/ZMA/SXHrvw19CS0V+gl6wtU+IXswwuSo+?=
 =?us-ascii?q?VR6twlg7Wo834p5Rg4JnFcGg=3D=3D?=
Received: from mail-am6eur05on2060.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.60])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:19:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwG8AMn7gI51F9BW1E4XenrXK7btZZ7Nt+sF7DwqRhscFYBtWK4QkTuqy9CSbjj3IWCwpo5ZdDwWfC82JtQDgm0MSjU5W1AfyryCDMlw0tWhQmfAz0JCTVmU69uD3aIc46r3g+gqUdur1u1JG/udXp2oNv7ie0I0VBVsqWMaxresjT1vaTJM981DUP+cDWz9VU6XBSKNrHpyGVGT4/Mf5Ha3RM+bW5vugX1rgxr1rA4LyYxiGHdjTyGZpiY2zdY+/t193Z1eFiHv4FQJG+CuSE6y8Hfrq+3/2TERsGvn+ETFWF5sA7xzuHGVMXbBIP2pAt+R63GsOz/vJwDadsxFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iehUthu5ABCNfiNWwQFgmW9GoRKagJzJWP2GY4A+Fk=;
 b=o/b1FHDlT53gzfP4YovjWmrcFJmvTmL6eRs6eHtc8q2aIcPxEuB4SQDToascoZbr1y1+tXl/Mky+LPzFYnjalAJtcOiIjQ18jxIMlDrD9Lh+mG3DI/Mf/D24xEpuSEK0tczh+cMiRfW21g06PD5JtsmIArZJrvt8Gdsc75tdMm6/7grQ4JXK29bwaZdjRpPS4Q6uTGycupd7+Bne8lx2Hb2Kh1r/8Bddj8cRSfje9rBo6FnI1dfxvdXxMQBcKVdfEkVYHro47vgM6PKO9U9Hgo2nJoMtJonAX8Eg5tLjAFWsXiJrvPIp58972Lq3VLrfNLtrtXV5twsRYyo1MBAGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iehUthu5ABCNfiNWwQFgmW9GoRKagJzJWP2GY4A+Fk=;
 b=aDKi8Ur9VctTH9YI0iHtVM2VP+NPgGEdf6MUjZfuT3g5OVGtdRtD9So5Xapd6ToMJ/cH4L2laj3i+yQvilEGyrdRLOa4tFofzS/GWGm3G0h1O3Fn2x4fwNNo4Ho4NNGpQO6nFF1ifhrgKjOTe12b1d5FzlZQLfETYqOL/VlzSupC0f6Xq5f+REm8klQrRGCxBnh6sxtDhWvZ3gt9KR/N4U61HspQPLkavMHT7qQRNRinJR71KgLw+Q8vaDobQS2dedtc3YJW0qvdlJLfcgXZgLwPnP+wPHIo4flSh/oX3wpCe0fKoqqN9Nudgo3FrmKS+qEOiuWFEmOq2sF/XDEJQA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6388.eurprd07.prod.outlook.com (2603:10a6:20b:157::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:19:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:19:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, Ethan MILON
 <ethan.milon@eviden.com>
Subject: [PATCH 10/11] pci: Add a pci-level API for ATS
Thread-Topic: [PATCH 10/11] pci: Add a pci-level API for ATS
Thread-Index: AQHbyVd2fPtPmqDEU0a8DUSn0WW9+Q==
Date: Tue, 20 May 2025 07:19:03 +0000
Message-ID: <20250520071823.764266-11-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6388:EE_
x-ms-office365-filtering-correlation-id: 24f62858-18b3-430c-80b1-08dd976e9957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rYYhknFzr4VvBPU9EO3mia5WOtNW31+WwyAbZH82l2ycXDB6HDM4N/afPB?=
 =?iso-8859-1?Q?zGfy5DKv7nH9pj7+/wFUCJG+oLlfj5lAHNtDOXuG+49jMGSin5dl5a6xNm?=
 =?iso-8859-1?Q?Htsyk1OA4ci6Nxysmk5wbRtMEliHupM4BFOmNzhBnYY7n929s2uOp+WayH?=
 =?iso-8859-1?Q?qZFXDmWneSgnm3M0zvDy2ktq8f1cIjE1T1otX6ErD3z48xmef19cOF8+mU?=
 =?iso-8859-1?Q?J64ZP0XZNijxGiVx8aQaVjgpJJOaHS1BbXUPzzSvQqwrG7CkRcJUwIIfwH?=
 =?iso-8859-1?Q?sh6/DWekmqwIuNJ236NoC48o00BSSVD/uXn3uCkYlrn3rcQfUyT5zbxt6g?=
 =?iso-8859-1?Q?ffDr+Tn/GPADDtUvq0hsPEEPPLNy36OVRSc+NNj0+xINXLNoRiFV14X0Vd?=
 =?iso-8859-1?Q?F32+IP5a1z4GEW+ZPoalKxDnZyJshhIobnl9Rz72ugxA2c0QkcD5Dv9Rv9?=
 =?iso-8859-1?Q?NqeZBgdaRZOmUKEVZI6ri4PmEAjZDmzWw+zM7980nqn+Fvl3mZby+iZQXh?=
 =?iso-8859-1?Q?HO5kMl7aIfQyVMQ+YShr/MwaoABz9o+WsFHQjJxKVUG+Faeg/fClOkQPkU?=
 =?iso-8859-1?Q?V17hXmFXxPZyTXDMnVyo1FGUixzDRQOue9dfWD4MjKWhxeVPKa+0KY++cM?=
 =?iso-8859-1?Q?U0NLciwhjByJekdGhlpI7y2wNTJL+XNEDL5+hWL36pZhMZ1FZPWEJQvRV8?=
 =?iso-8859-1?Q?o/h4W26Grfprpk+DE/yAVkv58vwSYy0Ny1ZADfD2HUK4qwEQuUlrLczgF2?=
 =?iso-8859-1?Q?z9NU+kdnKTf2JkrwX6eUsz3tU0dMendCyzBOfsdewuLEMAd4j0+vmPgR7K?=
 =?iso-8859-1?Q?BNUnJDxDMJde0QgWahhB271gsNJrCC569ucfNjy45gghaE7oSTtJtOJn7x?=
 =?iso-8859-1?Q?EwTUSgMv2OGeOdGLbzb4FCjmjlUXfx8pkjLNmYo747X1vvQAFnxJ+xj1Jo?=
 =?iso-8859-1?Q?6Jm+ik/g8aYS6duuh1R2LNxKiUoFCLqyBH24IW+GYWtyCk7a4cDoOkawNx?=
 =?iso-8859-1?Q?+XSYVrghScdRNHlC3TF0xfgzcwa2x15nY9Mb74mO/yLwP4zh/QMFryIavF?=
 =?iso-8859-1?Q?oZo5lcQfFf0jlbiJGd2reEt0DP5gXqUO8SJa18MOe+FOyJYQ0bkXNWntgq?=
 =?iso-8859-1?Q?tux4f8W4zOVHTe09y8PhbSSvBEg/lSjtXBBzTpBgOLZ46ouUOe84riV96N?=
 =?iso-8859-1?Q?cNU6fU6XFPJm3fRkJYOXztZOzSX8AAyPmz2CmYPWYKPTpM1pjfmGucCh/O?=
 =?iso-8859-1?Q?+Sm3dUbtR0BuZky5kG//x9EM7ENM+kA4/M09LO6u60Sv/JqIi08bhlYF8W?=
 =?iso-8859-1?Q?gy+AWFmgcag+bstc2iL2iktIaGgfRudXh564p0BmAhuqSFsiXDNAUQwX5c?=
 =?iso-8859-1?Q?fB+9rNHNRQwPXYLOBwUiVXSDSLh7vTuo9/VUSGsW/7hQ5fS7kp9IJF4P5S?=
 =?iso-8859-1?Q?JUfMkh6RTdlTmzF5EW1z2G8lI1SIRWuRM4epvVASq/UDUBcWuaY47Z/7u3?=
 =?iso-8859-1?Q?D0zDQGfehA8YnO0Tm1mqMybeehOIcx0BaCkF8ZgwMSjOIkl8IIgvLuiN3w?=
 =?iso-8859-1?Q?f40sMqc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3wNKdRSshZCIfTB+PPZ/CRYBSYR4VWYh34xUvpqQp2acMaByfMRGvJhEe1?=
 =?iso-8859-1?Q?ltyKLzMiFeGN2H9T6lJwd6yFFL/unECdgZzQqUGB3QFhr21x2a9TZyfRHa?=
 =?iso-8859-1?Q?xigCt8b2vw9wGnBVTQE8ciiHNmhJC85+DQ6YjkR18EyRkqN7suwlMtAd/s?=
 =?iso-8859-1?Q?aoyt9GmbQDYsRIFgXL/XL1P4EhcUKbUWldD3L5ilLXLYV/085u1CZ+QKav?=
 =?iso-8859-1?Q?l4v2KLRxPjdkQEny4rdWs8m9VFcu3nOUd93qBuLL7ONGxIi9JLiK0mh1W5?=
 =?iso-8859-1?Q?UhVDm2VvmnTFBlAc7VsV+7zqJEryKgPU2yqyzUJoJTY2aeG0OIqv6TdNXT?=
 =?iso-8859-1?Q?E5HYrWioNm6+VVho0kdWOeD+79tGRYVEzCy55p8N0npV+hRpuoqtIWpkiD?=
 =?iso-8859-1?Q?8/o+yCZvzGH3CrXE8RWyvlmWOy/NpXNog1t/4zKeqK/mjxmqXtIHOXDjCl?=
 =?iso-8859-1?Q?LL0qINHDKUv6PPbH8gHvdIP/cUkJAeX5g2px8eWsLW+Z7dTnnh1tzm7kAG?=
 =?iso-8859-1?Q?HDda7CAJsrn1do9RJHh2asA+JrFo88NvToL7Whj7qKjsi6Pm6d/gIf/TS5?=
 =?iso-8859-1?Q?deJe0akKysspJll6iE+NDPyEaff069rJZwmGANMC3PYqhk480dE6tBOOyJ?=
 =?iso-8859-1?Q?5/P5anRtoNUj7GXumrKEtGYY0oD7mLMhL1QdKYeRt2RUE2ZGhs52QDwGJe?=
 =?iso-8859-1?Q?dK2Pad7YGYNKPkb7cLS1M28lWdwNruK93JCyulOQ3a5t8LJPlJ6ppYbHN/?=
 =?iso-8859-1?Q?z8kW/smWPS6CD9sLV1O3mMVYJ7FjZDlXG2KoU2lLnw8uuBgCI/1F0bZlAR?=
 =?iso-8859-1?Q?3tOkjlAJ5LwuVbc3ypyljiGqcuclOctfeK0GXbiyLQ40dz9ka/s64pVA68?=
 =?iso-8859-1?Q?1/zMQZesK6yXwraA4wPAvK6d5hhuZ1WYIGjrjqUSxHbeF4FTnuO9QexXGe?=
 =?iso-8859-1?Q?HWHvVSrFhp2pykRoRU/jOXq6tV9mfVItY8VrT6YyTh1raVkZjW5evf2VuT?=
 =?iso-8859-1?Q?kCsSauhQ7ChX4G7pX007qur2wNGs4zFiJMzX+0G9zpDkZvYDdBhjLlSnEb?=
 =?iso-8859-1?Q?Z5Mx2JSXuVpvxcdc8VxJpY9IcXLCum6VzRNWSs4RB5PbS9smj6h80K+JwF?=
 =?iso-8859-1?Q?GyottULwpfgNv1PbX1uRnsV221wgNLhIDkBeqNMkwsKivQG+PPI84Izst5?=
 =?iso-8859-1?Q?LnK6deoyfqzB/xDVNuugkhN/BAZtNgwQXrsTvBCJOYOG52C4AqDok9zrnV?=
 =?iso-8859-1?Q?WNFd8emOqjGk1NZcv6X5I9Y6df0N/wtzl8upe8ueBMhp65IM3fLbQ/NVZd?=
 =?iso-8859-1?Q?MId/BnW9coxl1bly8rxeZOuEP4MlHuPZLDmbj1CAd+1PlmrsySNpVhhhBG?=
 =?iso-8859-1?Q?S0H1is8x/4j8It7tjqBmJRr7Mhpf4BxWXiHMCNSjEdOAF1nCmX/l5TpIHK?=
 =?iso-8859-1?Q?YBrZcuNyenbD2cg7PjvtkNKMmqF8mCi4AWxa3FgP1Iaudhu5JgTrWMRdYK?=
 =?iso-8859-1?Q?pb/RL8/1h2UtMv8C3igj9FO5n+L1tSf7GJRsApqu0plOlKt8c8nspnBKFs?=
 =?iso-8859-1?Q?KJfGfnBfd06JvT3sPoLmM9pR9BkQrqg71uL2PwkY1oZlA8TEbT2Ek7x+i7?=
 =?iso-8859-1?Q?ht5oZb/6ce4+YRatYqAP6zojOskjScrwERstmOCU37aiMial5BbwQwEajr?=
 =?iso-8859-1?Q?56hrz8OENznJYpKAlSs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f62858-18b3-430c-80b1-08dd976e9957
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:19:03.0693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ef7IYVLDReaXxDIgLPGdMux6njBA9FUkSxamHJqCu9rqcJz22PGOvaACeMJ3ElyVfvj0q1k6ioTEIv4vaZ5DZRyf3v3HJcTOQycxQmZ5h6McFzfz/zikOFiL/u7HvTsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6388
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

Devices implementing ATS can send translation requests using
pci_ats_request_translation. The invalidation events are sent
back to the device using the iommu notifier managed with
pci_iommu_register_iotlb_notifier / pci_iommu_unregister_iotlb_notifier.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Co-authored-by: Ethan Milon <ethan.milon@eviden.com>
---
 hw/pci/pci.c         |  81 ++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 126 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index dfa5a0259e..0c63cb4bbe 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2987,6 +2987,87 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
=20
+ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
+                                    bool priv_req, bool exec_req,
+                                    hwaddr addr, size_t length,
+                                    bool no_write, IOMMUTLBEntry *result,
+                                    size_t result_length,
+                                    uint32_t *err_count)
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
+    if (result_length =3D=3D 0) {
+        return -ENOSPC;
+    }
+
+    if (!pcie_ats_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
+        return iommu_bus->iommu_ops->ats_request_translation(bus,
+                                                     iommu_bus->iommu_opaq=
ue,
+                                                     devfn, pasid, priv_re=
q,
+                                                     exec_req, addr, lengt=
h,
+                                                     no_write, result,
+                                                     result_length, err_co=
unt);
+    }
+
+    return -ENODEV;
+}
+
+int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                      IOMMUNotifier *n)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->register_iotlb_notifier) {
+        iommu_bus->iommu_ops->register_iotlb_notifier(bus,
+                                           iommu_bus->iommu_opaque, devfn,
+                                           pasid, n);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
+int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                        IOMMUNotifier *n)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    if ((pasid !=3D PCI_NO_PASID) && !pcie_pasid_enabled(dev)) {
+        return -EPERM;
+    }
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->unregister_iotlb_notifier) {
+        iommu_bus->iommu_ops->unregister_iotlb_notifier(bus,
+                                                        iommu_bus->iommu_o=
paque,
+                                                        devfn, pasid, n);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
 int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
                              uint32_t *min_page_size)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f3016fd76f..5d72607ed5 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -462,6 +462,80 @@ typedef struct PCIIOMMUOps {
     void (*init_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
                                 IOMMUNotifier *n, IOMMUNotify fn,
                                 void *user_opaque);
+    /**
+     * @register_iotlb_notifier: setup an IOTLB invalidation notifier.
+     *
+     * Callback required if devices are allowed to cache translations.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to watch.
+     *
+     * @n: the notifier to register.
+     */
+    void (*register_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn,
+                                    uint32_t pasid, IOMMUNotifier *n);
+    /**
+     * @unregister_iotlb_notifier: remove an IOTLB invalidation notifier.
+     *
+     * Callback required if devices are allowed to cache translations.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @pasid: the pasid of the address space to stop watching.
+     *
+     * @n: the notifier to unregister.
+     */
+    void (*unregister_iotlb_notifier)(PCIBus *bus, void *opaque, int devfn=
,
+                                      uint32_t pasid, IOMMUNotifier *n);
+    /**
+     * @ats_request_translation: issue an ATS request.
+     *
+     * Callback required if devices are allowed to use the address
+     * translation service.
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
+     * @addr: start address of the memory range to be translated.
+     *
+     * @length: length of the memory range in bytes.
+     *
+     * @no_write: request a read-only translation (if supported).
+     *
+     * @result: buffer in which the TLB entries will be stored.
+     *
+     * @result_length: result buffer length.
+     *
+     * @err_count: number of untranslated subregions.
+     *
+     * Returns: the number of translations stored in the result buffer, or
+     * -ENOMEM if the buffer is not large enough.
+     */
+    ssize_t (*ats_request_translation)(PCIBus *bus, void *opaque, int devf=
n,
+                                       uint32_t pasid, bool priv_req,
+                                       bool exec_req, hwaddr addr,
+                                       size_t length, bool no_write,
+                                       IOMMUTLBEntry *result,
+                                       size_t result_length,
+                                       uint32_t *err_count);
 } PCIIOMMUOps;
=20
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -495,6 +569,58 @@ int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *=
addr_width,
 int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
                                   IOMMUNotify fn, void *opaque);
=20
+/**
+ * pci_ats_request_translation: perform an ATS request.
+ *
+ * Returns the number of translations stored in @result in case of success=
,
+ * a negative error code otherwise.
+ * -ENOMEM is returned when the result buffer is not large enough to store
+ * all the translations.
+ *
+ * @dev: the ATS-capable PCI device.
+ * @pasid: the pasid of the address space in which the translation will be=
 done.
+ * @priv_req: privileged mode bit (PASID TLP).
+ * @exec_req: execute request bit (PASID TLP).
+ * @addr: start address of the memory range to be translated.
+ * @length: length of the memory range in bytes.
+ * @no_write: request a read-only translation (if supported).
+ * @result: buffer in which the TLB entries will be stored.
+ * @result_length: result buffer length.
+ * @err_count: number of untranslated subregions.
+ */
+ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
+                                    bool priv_req, bool exec_req,
+                                    hwaddr addr, size_t length,
+                                    bool no_write, IOMMUTLBEntry *result,
+                                    size_t result_length,
+                                    uint32_t *err_count);
+
+/**
+ * pci_iommu_register_iotlb_notifier: register a notifier for changes to
+ * IOMMU translation entries in a specific address space.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get notified.
+ * @pasid: the pasid of the address space to track.
+ * @n: the notifier to register.
+ */
+int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                      IOMMUNotifier *n);
+
+/**
+ * pci_iommu_unregister_iotlb_notifier: unregister a notifier that has bee=
n
+ * registerd with pci_iommu_register_iotlb_notifier.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to stop notifications.
+ * @pasid: the pasid of the address space to stop tracking.
+ * @n: the notifier to unregister.
+ */
+int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
+                                        IOMMUNotifier *n);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.49.0

