Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E6EC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4d-0004bI-I4; Fri, 21 Feb 2025 03:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4b-0004aa-Vl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:49 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4a-0005j1-2F
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125268; x=1771661268;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L+qfiCqDv/FvxxOldZORUEjs2F9iRklyEARtcbtk2HM=;
 b=URF65CE1xySsucr/Xxp8+pFh5EHmXDhHkT882Z/AK03SgTT48zy/DMHh
 j4cTxLzcU41AMQRU8Xys83ta+FHdwxKEn0LjGRRKfcUl2a5XIxxkJ/xiZ
 +puuNBJx59NJ+fCk67Y0Bj1d+LrmXfDvCDJVE18Q5qcyvzr8n/81A0fvN
 gEv/4Txegvw3IJmErPAGQzcCC9lAz8KP0T2SIKL2OnZrPGzcTPi3GePWn
 MmXE+CI/ei5cPMUZF/TDZhNJuOY/QDcTAdYmVHUAg1gTkIT2g/HP+3c0V
 0987mZoOMGJUskPPnNLThQ8RMw2eYhaW5F62MDIZCMPBL1OP897PcYO1c w==;
X-CSE-ConnectionGUID: Wf/yfAdwTCuk2I05uBpjOw==
X-CSE-MsgGUID: c0uuOi0zSvy5qzlj9aytxA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394141"
X-MGA-submission: =?us-ascii?q?MDGZIDiP26ztFt7uBd9Wqr1vW2XC1JFklEdlR1?=
 =?us-ascii?q?8T5Wz9PyVMRUcDhzMsoJBdicjSrnh7CA5poRlPNYNl1hXGD1Vy2JHguV?=
 =?us-ascii?q?0Uki7Q5yH3wZlfC47YPC4ePjyh0mA2aj0o+/uYHSzgx3mMT5wXq5Grmh?=
 =?us-ascii?q?9Zg+Mfug4Vj2jkbWkcdBPCHg=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:44 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSU/HnqJZFt5YOdQSlurdfXEAO7te+0Yp7vGLzK9cNDrJKkvJAWq6QQ05auNO4ohzUk/72seJPfVuAv3aMDMmCZbj2t9BGd/Jw4Wa0wOLiGGvoKDiKcCxq5M8lPGYCF+HEi0861DH0oivv0Vqm4XrvXP48MLz9p+I307AbL0WdqZqEAv6uZ8CBtMzR4CSXymICrN2cU7aUL1b0VE4MCqdAexUSS6OsxGsPeQKrW0zvz+e11AdTFGgug/1wWL9IzrnkZBt90RhD3/kx8Y/Bg4yGOqv4pLsVYc1FczY90EXIN+NZkXTaV5wrdTZUbmEHDs8/PWQCXPCFydk8XY5XAoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Quf2k86fFz0ZYXnqnyMCqldIOYG9IMWVRxd9aH7T6rw=;
 b=R4eWAivO6G+RV6LkKkszVAxT/RKxS049nCOv7ct0SLmh7kKKkKXfsVsDHOJHqSlsKiS4rhXvEP9f8Ankv8QTaPHfUDDcS3we390wCPHPoFmSJGjk1XF4d5Gc6hn/fEq4njGol670zavgpStwc29UIHCbHFNSFyYw2JpKA8bHXgZehh+2S7+8cXwPA0IZp8+7fo1n0UAg6q4k5D/pnshVrkeJ1i7IdpEn/ZCyxgq8mzGHYdg8+VATA3PixmFmwoniyecqxBYWvEKyRMGVpta08YSemYZFS7yPvKucJT8AlMF2oEt3EY0wHzGiHEmBb9LA1ma/GHqJ5rfhqbhmgd9fEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Quf2k86fFz0ZYXnqnyMCqldIOYG9IMWVRxd9aH7T6rw=;
 b=ay733PRMPTMOQnpFpijianmm1Bs/ur/cYCGUfI8uaFEkVp5Xp90TFyhP/nggRk87r5tW/RX+5OP/eC4q1qkUpl8ZR9HdAAS1H4calhrWODO8gvnrCfEnH6otH7ujaPMUy7DRli1b5q9vA/Xhz44nD7Y5DUO3mDdJQREuISu60n5n0B7Xk3ahYHW9UNooxeiD4COR4UXDEk8SeFx5DoQrNnRpO2Ns73JIyiqyKpDri0MSfMbW/Ah8a07YHJSdXU5iKE4KeocNzUr1vDMZc+LKybioDqr5ftXiL3iWC+uqDGjaCLLvOaJBULCoYSq77ZQE/aw4HqfzHHs4/enSiyJ6WA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 15/19] memory: Add an API for ATS support
Thread-Topic: [PATCH v3 15/19] memory: Add an API for ATS support
Thread-Index: AQHbhDetiRjXB89bjUaSrra2Zx/Lyw==
Date: Fri, 21 Feb 2025 08:07:41 +0000
Message-ID: <20250221080331.186285-16-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6459:EE_
x-ms-office365-filtering-correlation-id: 8f67dd60-2edf-436c-af20-08dd524ed0ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jlUvVhE5BcWhAztUZEqX5hOXai6aIbalJwLyWkH/os8GLiTKIODs+2Ei1O?=
 =?iso-8859-1?Q?aalJvJ97V82/aw98AihA4pkSggDV2/RqVPAAztgwP+gU/2u3AsHPS6Tvvq?=
 =?iso-8859-1?Q?NrWYp7NWMpSMNLrhzxt2tL3VWwHgQ9JJ+N6RsKd8uVaDgLD7HNcGQoHVcS?=
 =?iso-8859-1?Q?akiuJqDNWEv/mOZPUlO9Lx48SUjU+IsHbv06+NtYA3cLnlL9FM3rcx9uBI?=
 =?iso-8859-1?Q?+3F4G/ejJg3UANUAa7a1jNtvU1f76/cD2zvaxnGfn3ZC4M2jJPqccgtGJC?=
 =?iso-8859-1?Q?iGgnsn7ywMzBc/U5oMeLnl7+PZwIZx4bBX56SBEYDWhXMfhraVLQFh674n?=
 =?iso-8859-1?Q?UbLIF83YeVaR1+O1WiwuXOIXsbcZiSS4nKAHwZmk0YBV6iRzsOkVWGTxZs?=
 =?iso-8859-1?Q?W9O8/OV4KpDf4r0DcGwJFjyJ/yqEaiWizevOUZLdoZjYwgeijOMpusdpRM?=
 =?iso-8859-1?Q?iNZEgWQSO1N5tUufuA8CyguOagER3wbXlzFEcszngDz/VRx+q9sPTumyni?=
 =?iso-8859-1?Q?QrAWNmQ6pkj6GJNu9P1t6rvmpaghhCTFpMLcCeCh78Nunfvv6ZqRLtp1se?=
 =?iso-8859-1?Q?s+79FMH+aBu3j+OO6Bqz21vCXq2GYMhUfjPSNOGh0UyyAtZHsPAqC54RjR?=
 =?iso-8859-1?Q?GUVKNP5Mifc4kGpLpZssaPFCnq7vT57YoeBc7gSEQ2oygmOMhQaYjwqFeq?=
 =?iso-8859-1?Q?wtmx9yEYesSmtjgRE1tYMhIX3v9ZPz/4ArHwSZmywrvwM/cD+0kShIcVRT?=
 =?iso-8859-1?Q?yk1gpKSma6kW4gDgfqttp+q3a1hKAxif9Ry2BL0R9CDPKQWBSEL288MeAN?=
 =?iso-8859-1?Q?TbBrM/VMURrD+z8gayaHnemQ0CR/Df7sbaGZ3sMrqQCKpceDylav5utTww?=
 =?iso-8859-1?Q?y5P+CW6KnJY5Sv6k1rKKZH/Dc4ndy38dg9cA5ByoZTPKAhKLcn0M6YLguZ?=
 =?iso-8859-1?Q?G3+Au+thRkjcq22/ex/S+gVOypW13E87KXZgyxyz++LmvtO1ZM9Z59j28n?=
 =?iso-8859-1?Q?phrDHJdJANlza26Xun/gXK/EDCfjfdfWfSDF60kgCibCpmzZ2dF8fZ0HbI?=
 =?iso-8859-1?Q?1nHJUN6zpfiQY5/Lz4PAO+sUsrFjJ59/CoRpSdSlIs5/ftg4BNVrKeBHTY?=
 =?iso-8859-1?Q?VMbj7clrtHatPE1p8uCJfXVBZ4i4x2lPLSZ1HoFzNHJXd10+/8pNjwZQmN?=
 =?iso-8859-1?Q?YAkRW7aJL39jf7FCPE3zGuPUtmGq9v65jdGGEN2oPkNwT4O+aXnoFyo+Yq?=
 =?iso-8859-1?Q?hBw0eHy8Miothzomei1sq58bviP9zk2ZLMxJIRxiihKG6XosdFX0amwssT?=
 =?iso-8859-1?Q?2RKtEfc1hEJTEzNK6Ht+CPiv0SeinnvAapQpyqYX5haWRRdIOQGFs7HRVK?=
 =?iso-8859-1?Q?6WBjlozXT7HeLojoxkW30n0KQ/Snfr2KpVjX6IP2nDOVOJOJkQ3c31TS27?=
 =?iso-8859-1?Q?UOHBp5RlrYgfLwlip7KpaUWMO/5KI1WfrtKlJdU6y8sYout43zcYvru1DY?=
 =?iso-8859-1?Q?0fKzhn2zZy6GIL5uCs3kiA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xR3IaUU3Nlp1iFNuxu6/kaqzkBASecqLvGZtwj48937F3f0PM9sd7HAmoH?=
 =?iso-8859-1?Q?Qzk7jOQsmxkLp0TysNcBtI9L6PHNIlUqMYSQ9wBoKyZrPqo6tG92f4I25p?=
 =?iso-8859-1?Q?xxRjoa3pvpkSdpSyt2anEqUDc0/joIuZFmQJ69znPhJw6puM+bjdedMjXT?=
 =?iso-8859-1?Q?V2Fw744/+/lWF8zZTznDrOTApZ5Guw/uzAg5a4At9zLwJ2Lt/iZwCUKvZZ?=
 =?iso-8859-1?Q?vLlzWAkF5tefhGbjAQ2P1G2muhwERJMo7BJpAh7hN5z84TF9ywmSMPVbCS?=
 =?iso-8859-1?Q?b9nZsJhyrMASHZNKbWDmQr/KWWuB8k21lYjn89rfXmA3YXJFxUteffy8gU?=
 =?iso-8859-1?Q?bYglvyez17H9hRlVq1asavj/VAhNvFWGGPbrs2vaWhBAEVrEgAKqNFNROy?=
 =?iso-8859-1?Q?S42W3iwxzv5Dbi1fXu9RXDOv3PPu+OFmdKBav9lXVubuLvCfoy/Y7GAw0O?=
 =?iso-8859-1?Q?7EJj0X49X1dgAf8SzcvqMLoyrTETrL5jVDHCpAWHJIxe0/9Alf05RWim46?=
 =?iso-8859-1?Q?vPHUZ1PdSXbx7VpHYGr1d9URNzceLU3WSQ/nk84jqLnmFFz1YFHAAi69Gp?=
 =?iso-8859-1?Q?XsGo3Hqxkq66ao8u2Y/gq/ozCkB6NT0bHqG2sBA6aHhFWSMgirnmj9yK1e?=
 =?iso-8859-1?Q?qmBNR54eBYcVl6OK8EwwFAeq3BRFeEHdrfrqjc7IT+q+euf8TuUQ12DPlc?=
 =?iso-8859-1?Q?+yp2c71tHmRqwWGp7nKsCoSMkWlWt7HhHeXQaZIlvX4Cj2aG/7a0aVXWxT?=
 =?iso-8859-1?Q?7qof3Wa2y0OU2ZfhtxVWO9wTzcPQEzy2EVXrAsAnJAsWkN3h+aWKc4su7Z?=
 =?iso-8859-1?Q?uRgjQvfag4ddVD134o7iBRm8kYUC1bVkW+lMcchjuJyjIOwOTX+6Qq1aV3?=
 =?iso-8859-1?Q?M5Ok1ozZx150oy3s9rUDV+alkkrU0A9V1/lJJPusfetbJrSrogf0nVYVuF?=
 =?iso-8859-1?Q?fmzlB4VEv/K6vshQk4nDTOtNs5256I58bE9Oprz6iSm9bn9uRt3AlCRlH8?=
 =?iso-8859-1?Q?4RuYcs9vHrxsbOhgfFhSrqyBzz8iPoaIoX7tl8pe5mc/CWX9DCy5SD6aNp?=
 =?iso-8859-1?Q?LEm9qOkCbt6BenjMQWtq0tcAXnvCMLRUS8RozkX2WZZKg09YOfcuNtTS1W?=
 =?iso-8859-1?Q?lECGfaD6T9k5zeNR23TMx/AhzrJNW8jXTXrWNHiN8LTWXxqjGzcH48icxE?=
 =?iso-8859-1?Q?9mDhwm9XWEg1p3UWkYjERYVyzCoD/T4/vAWlrIX2vTN7cOebwfW6hu1aQI?=
 =?iso-8859-1?Q?RZ/vw+321pdvtd5LXomf4EQnf0iZhyMrkWiXPMD57xcLm/TQ82HaKtQ8X0?=
 =?iso-8859-1?Q?EHmF5CN6ElJfqTL3x9nwZ1Hlse481xH9H7EAPKvcNADtxV6KlBP62v/Nt4?=
 =?iso-8859-1?Q?AJqmOHN0gBeLvkmNwVVx0RUEBsR73Q2oacGddfy/B03cAGuqcA986IP6i3?=
 =?iso-8859-1?Q?SJs1u/4OyLT5n+Rwc1fEkfWWJUpg2GmT0rf9ENxUwtO1xXUCQGs0/bRaPo?=
 =?iso-8859-1?Q?jPZilygxdTRquRcqyK6V+By12O6YB2X/kyx+W+1FXCmhu46HOTvQtWU0aZ?=
 =?iso-8859-1?Q?W7FxYQqQkmfwOw0p/v4kA3McBmVN17oS4E+mI39KF4Nm2DlkKZP0Y38W+b?=
 =?iso-8859-1?Q?4kDiG0SIiiH6DbBQgAHJhA5Q1StJYG4ru6WsjeAMkfp+UyahuU81wNu8Ok?=
 =?iso-8859-1?Q?uSm8wGNiMmrEKmYSWr0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f67dd60-2edf-436c-af20-08dd524ed0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:41.4874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dnq6yRAl1ttULGq3lYKYu1GOQ6jsz8dtry1sCHXOhnSkbsv955ByCJi54Jj+WCO2qyeAQFlDd0i5d73n+J3H8TbsJ/VhIs4NpLV116BHoyhy6J/N85qpca3dFXbFqOjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6459
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
index 4d240cad1c..9a8e765909 100644
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
@@ -535,6 +539,20 @@ struct IOMMUMemoryRegionClass {
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
@@ -1892,6 +1910,14 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *i=
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
index 4c829793a0..f95c602a46 100644
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
2.48.1

