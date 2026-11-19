Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE51606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=LN52BTiH;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=aubMYyoK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4mB-0008Qe-AN; Thu, 19 Nov 2026 11:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1xU4m0-0008Px-Rx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:14:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1xU4ly-0004AF-L8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 11:14:08 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJFJQbH4078318; Thu, 19 Nov 2026 16:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Rbiqi1awVphi4zYGKMFhBQ5TJBUdZQQQaFl3Qhi/7Rk=; b=
 LN52BTiH18FmDqAy2eZ/H+s7hMzuTLtygR2921lupif+DUHeKA4BifCLjW8rQqP6
 s3CF3wpJLwMhHb2FeJ0AKHYhCT7a5E9YbzdyaI+bnhUGOVnyjlnB/XjymDdsBK/J
 OjvIPq6cRjuBEAH1y2W3pfmyn8RVpFIFs/9xUZzddl83ol937DdiUC3C7uyUHTSS
 Og2NUgFKF66W3ZtWjPIxRFB54RoE68eT/yd4AZZR+aGaRa/xP2jSctIts7h3cS4w
 3IPSHNRPjKH8c+pxAYGMc5VzHxBNGqCJG3CGDFpVGyyeRh3thoAiHJeNukrnnbk/
 tUhDu5YDWM1NxNZDJlnu8w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytrb86d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 16:13:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6AJG3iTX1733860; Thu, 19 Nov 2026 16:13:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4j21pkqj55-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 19 Nov 2026 16:13:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8SOE+j9h2gn9GFnVY1JeilPAkLKAm4ssa7FwYazo723vo15wcDUVTofTajcKZTiCc5f7/ltV+DBlfHH/Xsg874TUqePYVvjgQcewBb/6VZA3vaqi7AyagnFkWSs/ljnVcRx7a92k726r1pjTfs+UttNV5G1+IDnHPmBm2Nzq9yLoHMjkA9IPUJ0zaZVGeZZq1QXCKWMAJJHmQIyyD0QpXBkmztmLxK353blhwSMoqhZg9O57pZpPSAbBZ/rsPvaL5ca02nxOasq0W5H4Yplvgoj6vkWGuPrC4eoaBe/YS2+3vzHPOSHGJWeD1Q/ty5Ww98rW7ZQ+n6S52zAhPGL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbiqi1awVphi4zYGKMFhBQ5TJBUdZQQQaFl3Qhi/7Rk=;
 b=bIyG1+gHZb1yQ6R+kGKsJso1Pf7jdPpXNzuAS+We09BvDA1OsIOdu8xDPyzBK6blJq9v5q6YtOv0xP3TeoKtP45hqnT8OK9V3BfiPl5pvklGsWhcMxuZw3bZ28t/f70l4JzCWCtZoAJTs0WtlG8/IMl/NDcR/PlxW+qPSvGMwegZ0feKKnYn2akAKTvjYke5q3hoCwDDKfIUp8lXU8l0yv+dbjzY7KwP65Krsc3y1IO3JrdO8m6KUtj8sSxU4ns5nH2VHYuxT9Z70MNDRHIDz6k3bxUUdob7dcpxwNSbQYH6p0LErxHGA3Tkb8wEjMhcAcNK64ggYnNWbTxabGJgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbiqi1awVphi4zYGKMFhBQ5TJBUdZQQQaFl3Qhi/7Rk=;
 b=aubMYyoK/xmCuz51tx4OokGvLyQe0uMct9BeJsyPJc9/82TtK0v7BwFZjnJhPTH3kohx2lDZWsiGm3rSLkYeICK2sVBKU17ytPwDpv0G2FgABiv86zQVRXiYbi4X1Z5QcoB4mAjm3ZrsIeDfcxfTvj+whiECg6FaYvb98Q0JLM4=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by PH7PR10MB6058.namprd10.prod.outlook.com (2603:10b6:510:1fe::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:13:31 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 16:13:31 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Markus Armbruster <armbru@pond.sub.org>
CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: x-remote-object breaks QOM introspection
Thread-Topic: x-remote-object breaks QOM introspection
Thread-Index: AQHddqQgs/w8PeOnp0mHoXFGgyjw4Lcz9WwAgAD10umAAKlBgA==
Date: Thu, 19 Nov 2026 16:13:31 +0000
Message-ID: <C03B480F-3701-4DEB-A9DD-6C0F80A62568@oracle.com>
References: <87jymbjyia.fsf@pond.sub.org>
 <E30ADD82-0779-4294-B235-D27FD379C9D6@oracle.com>
 <877bi9e4mi.fsf@pond.sub.org>
In-Reply-To: <877bi9e4mi.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.4)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|PH7PR10MB6058:EE_
x-ms-office365-filtering-correlation-id: 1b458ab9-fa22-4092-18ef-08df46580db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|260925022911599003|260925021911599003|4143699003|56012099006|260925021311599003|261022105027099003|261021121427099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|18056099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: UYi6Vfh+hc1NQbnK7Af8EMfXHoENMP1GaWDMNrNnJ1c1cTS1SFngYRO9HCYGIaA9Ola4uKnVQ47D6qeSZyMX9lcBM4HlNtyeUjyFJ+WPRzzIjiY8k7oIketAE1RKmbpPAWBDf6PA5njkVOyIrNqZfI6UQ5TfmxYCyYlSCCcIdrYo5j/LhSl43gDEtKM+aBl+zwEG+Wtgw/7RxXOcVkysk8uutlJ9MVy/sAQamvh5AYn+cSbFg07v7leYzMUK5lmRzkATz/E6KLnbfZmUbunJpdPZ8RpY5o3TFzvj09CBBoBwq836JCTD2VpAmpN77iD1itn70uFHnPPDjNyWLQ4AiU1rh34vXG9BfHb/xK4M6zhBbnzB1GXzLmKJ74h1VBg3kX1mnu6u75w/3Ouw/irKY0AcNaPex1nWdqnO6jeuZLjvZDOQgDlEHdbDHEhLCsSsHmADcDQEodZo+qzuHVM9KuF2Gx6YQ/pdmqQcjghybPUV7i/Kgd4oheZimSN5yJhu8zYxkZ369+8PFbQW0KO6PuQV0y7NJX+q2GwYxOttLtGmCStbvoAtxI8VzlN9XGBN2i/QFvWcQD8D3FutdM78vT66CC2oepl+6nHU/lNhj3hDhdyMHRARvxhHW33H8ApE1R+xt+CPU2d2LgZoMHouO+C8wde9O7Ch/f3aReKONBSTs6y3RzLKdwalYnihATSASriF01tRK+QPeJoMUYhXdspRrnJ2cBoL4MiWtTrhODQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(260925022911599003)(260925021911599003)(4143699003)(56012099006)(260925021311599003)(261022105027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(18056099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHM3bnR3RktoRmhwQmN6WHdqb0FQNjdNUjJVTkNzek1qM3R4ZTVPR085VGZt?=
 =?utf-8?B?NDN6L1NSRVpNQlpKWkhUVnM4TkYvYkphSm5YaGh0OGNIWHRuMlVxK1hyMU16?=
 =?utf-8?B?K2FCckdTWHc2RzVDenNkVXAwUGVDVmxxcEVZVFhORUxEc20xdVMwNmJLaFFn?=
 =?utf-8?B?dWw0SGVKQ1JlSmpsbHlhYXFoMFhnT3dMUGlkbGVEclNwTTJBYmtFOGhXZUYx?=
 =?utf-8?B?UzhkTmJJNUp3RlhDWEhPRkF0K2tHZmRBcGwyRTloSUNhTkJYeDd6aUVyUGxi?=
 =?utf-8?B?SnpBcnUvM21qUzhTSUVMUTVscHl4ZzNlTWh0eGdpekVLSk90UzNQNWxpbUdP?=
 =?utf-8?B?dG53L3BaZlE2RHNQR0czeTNsMmxYSnpuM1BOeDY3QnZmei95dHVlU2drQk10?=
 =?utf-8?B?QXV5N0szY0NXOHpVL2pUazA4WHFvT0hhRHdkR1djSXkyWWp0QVZoT09oVDhy?=
 =?utf-8?B?UVVKK2xxRmZvWGNRNUxvTnpjN2ZIYUxUbHd3WDlYZnIxZFZEY09VaWRsNkpJ?=
 =?utf-8?B?QmtaTnhjdmwzOEZjTWpVL2xqRWdvek10TDhwNEJ6c0VmandhTUREZTZHdEd5?=
 =?utf-8?B?d2VEZGJYQS9BU1FsWk9NdlVkMFhWWWcrbXpEVGRqdVBNY3B4OExMUTBadWJk?=
 =?utf-8?B?ek9LZXhWUnExZXQybmQ4Y2YrNkY5SGgvdkpPa0ovc2pZR0UvcXBKbWhtYisy?=
 =?utf-8?B?WmZuc1E2K1lqdGs5UnhFVmdLQUFIYmlHOHVrdjE5cDdvUTlENFlRRmQ0MFFL?=
 =?utf-8?B?Q3BVNDREOXFNdnl6S1RBaGxVR2dRWjdwMWlsWVQ3ZldFc2ptaG9KbUpZY3ND?=
 =?utf-8?B?UDhEbzlyeWpMK2E1R0RNWEJCZHV1KzloTE5SQ2VxczQ4d0p0Yithd1pOblJ0?=
 =?utf-8?B?ZjRhdU5tTExZb2RiaVh5MWNxL2RlUUhBaUl2OCtXUEYvdnUwdjVadk1qMjZp?=
 =?utf-8?B?ODVwZzk2aXo4VmRnVU0vVVpYOFZqSXFOME9vWG9INGVyZGxBdWtCUUV4ZTEy?=
 =?utf-8?B?QmdDOFE0Vk5GQm5uK0gzVFZGWjNIVlJCZ3JSUUZFbXRjSjFjZERZN29XVk84?=
 =?utf-8?B?enJTTXVNTktHZHJnd1ErZTNVVjB4MXhtVjBTWHYrQ29JUjNkM2lpZ2tEWnZr?=
 =?utf-8?B?c2lkeHdwQzJiOHorSUZ5Z2JXVVhHSlJtMktnSUo3WGIyMmlRRVJZOHdBMlM1?=
 =?utf-8?B?TmpERStHWXVMNDRTSi9vQUdiWlg4ditpUmRjaXp2b2RRK0lXYWZLT3RiMGNO?=
 =?utf-8?B?RGdWTGhzVGR6NGxCR2Rla0lXcEU0MklwVFNhSGczM3VSd29VZFRQTWhoTUp6?=
 =?utf-8?B?Znd2aHRKMlNNcmI2SkZncktUSytIb0QzaGV2eWNQWE0xbVlQR1h6Vzg1aUJm?=
 =?utf-8?B?ZWRkYzk4Qm5KemVyblE3QjM1L1lkRmVEVzlLRVpubmtNbENGeUYzVHhCUFVu?=
 =?utf-8?B?K2xRSWR1aXBLY2Vkd09rdU9NdzJ3YXpLNVBnZEpybnUzT0p3SStkSVBqVGxi?=
 =?utf-8?B?dVB4SHlyWkowcWpsZHVUaUhRQlF5MnV3c1ErRWZHenA4STRQYXQ1eDhQSEp5?=
 =?utf-8?B?VTlVOThtaTRLTjlvTUpqYXNLYmhQOER1b05iUjg1ck5VYi8zaXZCaXllY094?=
 =?utf-8?B?dm5kM0VLcStmRDFSZUw2RXFIN1hIdmVlOExkVjBBU0tLZzNlKzE2MVRhUk9j?=
 =?utf-8?B?NWxVZy80ak1GREgyMXZLaXh3SSt1NWcwZU0vTmZGNDUvWXBFNGNiQm9HUVR0?=
 =?utf-8?B?eC9XYjc1a2JhcDkxTUZPNWhMZFp6YVdvT0NxWHJaLy9ZWXIvVnBkL2NGQjdl?=
 =?utf-8?B?TFpYWTRvbHBBSXZpYUdVT21mL1pIQVB2OVh3dHNhY0M5YTMyb3oxM1dJc0ds?=
 =?utf-8?B?bnNMOWxiVnphdFNVbVZYTWJXVC9TU1VycWc0UFF2d1pBN1MxOXFLcE5PanFD?=
 =?utf-8?B?T3ArM3VZQjRLcmZyakJiYTIrZk5VZ3JNSERoOHNlYlpYWTBweWxIYUNaaTRt?=
 =?utf-8?B?WU1pV3FEQ3hSaWt5WGs5YlU0VU5BOTJJdVc2bWp0OU1PS3hkSERxUXZKamZI?=
 =?utf-8?B?cVpKTmRsZE9mdUFMRDFOWEZoMys2VVNVMlRDMjRKYTROSE9wM0VLN1Z0SFhs?=
 =?utf-8?B?a3pEVnZyZVRWRjAxQVIwMmRiR2pFdWFkRWVIdFF1Mys4VEJyTGRybEkwV2Jl?=
 =?utf-8?B?WEZsRGNaS0JJQm9aa2QxQ0VCSWdQMmxjdkp6ODA4cHRsUFFNQXBDeWxRNnFt?=
 =?utf-8?B?QWVuNnZVNEk1NWdEZUxWY3FaWG5vK3NYZUNqZldGUkZQRkJDSjdCLzRVNlMz?=
 =?utf-8?B?TlFQVjNHYTRXVmluSTJiVDFiKzEyaHViYm02Umw1bWtUYlpEYmJUZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83CF0D48672471479820B751984ED479@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ySR5bsCF497G9fIPltIztjzNoqXP0EaTnx68aCY3nqCzOAF6gIatWi0PuUqpKaSFwRPEI9t8tnbkVQkn3cAu+4jpSRTBRZ7/DwaLEEibCqcc8E5syJDeKX3gym0ONWWKo0FEjpClLIvElGwok7JGelXKdcJXoBVoxKDd9sOC2cJ6XtNV7zf2o3EkW5h/eAfNOcrRWCd36qPQuNM6kteQ1iel9+Efkf9Ne+uVuYgcc5PJ21F5duEu6ZEssrUhLbxCLlEmoDZibtG6vdZ8Yo0XSQYRVJvuwAt9X3LYWlyGnFIUe319+qlyYb/u4nijUMTMUplKX7adLgMj6YYMoO6eDw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XaGwYHlu6ADPLtzwiYwgWC1qb+qivupnlt13/MEtFng88RIc33UvqRvVM8JW2FsDlN+Hpb/FYcRU95DfD0i5+TCbWCJQRssZZ2qBSu06W6Oy3wha/9XLmB5DrF8g2jcevc5mPSCTcwR5keSaTAR9FzKYTkkwP/L4gwQCReXvJkr/ogndjs6sv1lnF+42MyU+VgyM2HMZIoG1wuWLzjqxtY8XB7WbktNWnxqjVuv6Veto9gsKgi7JWc6Zqe1GDDXhZb3yUbRJ9JSiawzF40z58CWNJOpjYH4cq5mDt2OlrcgEz2CPpQKJYphWBX8M6iV7hAx0nu+AKwOXl5gzquG7Ab64GpogAkneHZLUAyhwUwQq1douQDLSWZmloZMsef9cD0RwmBQK9gUkPZOmK4hoCfxjm1R2DCPeo94fzlnWyCs0ChKTbdyfPn7dhMCXS+McvIs783W/Q6akbu8b2HsdzcZBj77LjHCvpkPbcC7ctEqDxvpL8mRxWJWm6rzCD36OfcmMhqQyAS3fajsxZDwAcsCTsobon7ZcKBeNTIKDSkI77tL2ra2ujCKe84K24HgZ1B1AXwmSXLhljJFDK87Yt6Vfxh0f3CedHNNk/r7mjCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b458ab9-fa22-4092-18ef-08df46580db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 16:13:31.0502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZgre6Z1KfwLYIR0MJF+xhlsIkDvvgEPIB7hREOI3jQU2qy9HygCWzG7Y1ZPamXHixmlWQCd8medhDwIZq/dMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611190064
X-Authority-Analysis: v=2.4 cv=f+Ldl+yM c=1 sm=1 tr=0 ts=6aff2046 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=ZiMIAIO6AAAA:8 a=yPCof4ZbAAAA:8 a=bSJSNQKEoZNnrde_pk0A:9 a=QEXdDO2ut3YA:10
 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-GUID: 5kiDuWYdQIBufLQbX7rRlz8Dd6BKret9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2NCBTYWx0ZWRfXxItAnoJYN+pq
 VzHr5EFDgcmTq0vgHdUKH5P+aUVg3w7WZyuLY1zB84qGh/BK+5/J+zbJj+98LMnJXsmX8iRA68o
 nCyh1B03ZoqevQtgwqm2CLTeXYa6MZelLf/HiyS4x5gZCst/z+lFlY3bSXtQsvFlhBxL3Yw/r4P
 MSiMZXigIdnakMvsfqHEN1Xj8IiP/tFcoCO7Wj5Hlo9R7EwT0y8y9sxmgRQN6Jj6qvarcCxqSZM
 24MXEc4PEvJnstQpwIXRG/XbqHGVRNkc5rKtx99jYhjQXU5BunQ0szQojmIhTbj+7dcFuxO68ay
 jsXRBHPGbFdlTyiBr0GkQeDPXM1br16XcoQxrw15pcZAhmLgB4zlrnYghLnodr6H81OT2Bu7DXn
 d58ZJeO1e8bTjhPOlG4aIsTNo6EEoks/HRNjEI2fTtgyJNwGDUfDffUXEt8CWVG2kphHZPzQATB
 QEXDTmk7mhcuBvQwlpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2NCBTYWx0ZWRfX9dKsIpvdr65e
 49408LXZg80d877zAODvIWAijJUNrRIIw12+qk83fU3T1Azefw/++FW9HQDTKXx99XJ54lftoUg
 wtsmtfas4nweZOhWAIQWUuFVzZT1SNVoKWhhvQOQ7vPWE8dFgzTn
X-Proofpoint-ORIG-GUID: 5kiDuWYdQIBufLQbX7rRlz8Dd6BKret9
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gT24gTm92IDE5LCAyMDI2LCBhdCAxOjA34oCvQU0sIE1hcmt1cyBBcm1icnVzdGVyIDxh
cm1icnVAcG9uZC5zdWIub3JnPiB3cm90ZToNCj4gDQo+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGEg
TmV3IFNlbmRlcg0KPiBZb3UgaGF2ZSBub3QgcHJldmlvdXNseSBjb3JyZXNwb25kZWQgd2l0aCB0
aGUgc2VuZGVyIG9mIHRoaXMgbWVzc2FnZS4NCj4gUmVwb3J0IFN1c3BpY2lvdXMNCj4gSmFnIFJh
bWFuIDxqYWcucmFtYW5Ab3JhY2xlLmNvbT4gd3JpdGVzOg0KPiANCj4gPj4gT24gTm92IDE3LCAy
MDI2LCBhdCA5OjU44oCvQU0sIE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcG9uZC5zdWIub3Jn
PiB3cm90ZToNCj4gPj4gDQo+ID4+IFdhdGNoIHRoaXM6DQo+ID4+IA0KPiA+PiAkIHFlbXUtc3lz
dGVtLXg4Nl82NCAtUyAtbm9kZWZhdWx0cyAtZGlzcGxheSBub25lIC1xbXAgc3RkaW8NCj4gPj4g
eyJRTVAiOiB7InZlcnNpb24iOiB7InFlbXUiOiB7Im1pY3JvIjogOTAsICJtaW5vciI6IDEsICJt
YWpvciI6IDExfSwgInBhY2thZ2UiOiAidjExLjIuMC1yYzAtMy1nMzgxNzFmNTljY2ItZGlydHki
fSwgImNhcGFiaWxpdGllcyI6IFsib29iIl19fQ0KPiA+PiB7ImV4ZWN1dGUiOiAicW1wX2NhcGFi
aWxpdGllcyIsICJhcmd1bWVudHMiOiB7ImVuYWJsZSI6IFsib29iIl19fQ0KPiA+PiB7InJldHVy
biI6IHt9fQ0KPiA+PiB7ImV4ZWN1dGUiOiAicW9tLWxpc3QtcHJvcGVydGllcyIsICJhcmd1bWVu
dHMiOiB7InR5cGVuYW1lIjogIngtcmVtb3RlLW9iamVjdCJ9fQ0KPiA+PiAtLT4gcWVtdS1zeXN0
ZW0teDg2XzY0OiAobnVsbCkgaXMgbm90IGEgUENJIGRldmljZQ0KPiA+PiB7InJldHVybiI6IFt7
Im5hbWUiOiAidHlwZSIsICJ0eXBlIjogInN0cmluZyIsICJxYXBpLXR5cGUiOiAic3RyIn0sIHsi
bmFtZSI6ICJkZXZpZCIsICJ0eXBlIjogInN0cmluZyIsICJxYXBpLXR5cGUiOiAic3RyIn0sIHsi
bmFtZSI6ICJmZCIsICJ0eXBlIjogInN0cmluZyIsICJxYXBpLXR5cGUiOiAic3RyIn1dfQ0KPiA+
PiANCj4gPj4gVGhlIGVycm9yIG1lc3NhZ2UgaXMgc3VzcGljaW91cy4gT3JpZ2luOg0KPiA+PiAN
Cj4gPj4gc3RhdGljIHZvaWQgcmVtb3RlX29iamVjdF9tYWNoaW5lX2RvbmUoTm90aWZpZXIgKm5v
dGlmaWVyLCB2b2lkICpkYXRhKQ0KPiA+PiB7DQo+ID4+IFJlbW90ZU9iamVjdCAqbyA9IGNvbnRh
aW5lcl9vZihub3RpZmllciwgUmVtb3RlT2JqZWN0LCBtYWNoaW5lX2RvbmUpOw0KPiA+PiBEZXZp
Y2VTdGF0ZSAqZGV2ID0gTlVMTDsNCj4gPj4gUUlPQ2hhbm5lbCAqaW9jID0gTlVMTDsNCj4gPj4g
Q29yb3V0aW5lICpjbyA9IE5VTEw7DQo+ID4+IFJlbW90ZUNvbW1EZXYgKmNvbWRldiA9IE5VTEw7
DQo+ID4+IEVycm9yICplcnIgPSBOVUxMOw0KPiA+PiANCj4gPj4gZGV2ID0gcWRldl9maW5kX3Jl
Y3Vyc2l2ZShzeXNidXNfZ2V0X2RlZmF1bHQoKSwgby0+ZGV2aWQpOw0KPiA+PiBpZiAoIWRldiB8
fCAhb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoZGV2KSwgVFlQRV9QQ0lfREVWSUNFKSkgew0K
PiA+PiBlcnJvcl9yZXBvcnQoIiVzIGlzIG5vdCBhIFBDSSBkZXZpY2UiLCBvLT5kZXZpZCk7DQo+
ID4+IHJldHVybjsNCj4gPj4gfQ0KPiA+PiANCj4gPj4gby0+ZGV2aWQgaXMgbnVsbCwgZGV2IGlz
IG51bGwuDQo+ID4+IA0KPiA+PiBHbGliYydzICVzIHNob3dzIG51bGwgcG9pbnRlciBhcyAiKG51
bGwpIi4gVGhlcmUgYXJlIGxpYmNzIHRoYXQgc2ltcGx5DQo+ID4+IGNyYXNoLg0KPiA+PiANCj4g
Pj4gU3RhY2sgYmFja3RyYWNlOg0KPiA+PiANCj4gPj4gIzAgcmVtb3RlX29iamVjdF9tYWNoaW5l
X2RvbmUgKG5vdGlmaWVyPTB4NTU1NTU4N2QxN2U4LCBkYXRhPTB4MCkNCj4gPj4gYXQgLi4vaHcv
cmVtb3RlL3JlbW90ZS1vYmouYzo5Mw0KPiA+PiAjMSAweDAwMDA1NTU1NTU3ODcwMGUgaW4gcWVt
dV9hZGRfbWFjaGluZV9pbml0X2RvbmVfbm90aWZpZXINCj4gPj4gKG5vdGlmeT0weDU1NTU1ODdk
MTdlOCkgYXQgLi4vaHcvY29yZS9tYWNoaW5lLmM6MTcyMQ0KPiA+PiAjMiAweDAwMDA1NTU1NTU2
ZjI2ZGQgaW4gcmVtb3RlX29iamVjdF9pbml0IChvYmo9MHg1NTU1NTg3ZDE3YzApDQo+ID4+IGF0
IC4uL2h3L3JlbW90ZS9yZW1vdGUtb2JqLmM6MTQ5DQo+ID4+ICMzIDB4MDAwMDU1NTU1NWNiZGEy
ZCBpbiBvYmplY3RfaW5pdF93aXRoX3R5cGUNCj4gPj4gKG9iaj0weDU1NTU1ODdkMTdjMCwgdGk9
MHg1NTU1NTc3YzAyZDApIGF0IC4uL3FvbS9vYmplY3QuYzo0MzANCj4gPj4gIzQgMHgwMDAwNTU1
NTU1Y2JkZTJjIGluIG9iamVjdF9pbml0aWFsaXplX3dpdGhfdHlwZQ0KPiA+PiAob2JqPTB4NTU1
NTU4N2QxN2MwLCBzaXplPTEzNiwgdHlwZT0weDU1NTU1NzdjMDJkMCkgYXQgLi4vcW9tL29iamVj
dC5jOjUxMg0KPiA+PiAjNSAweDAwMDA1NTU1NTVjYmU2ZmEgaW4gb2JqZWN0X25ld193aXRoX3R5
cGUgKHR5cGU9MHg1NTU1NTc3YzAyZDApDQo+ID4+IGF0IC4uL3FvbS9vYmplY3QuYzo3MTANCj4g
Pj4gIzYgMHgwMDAwNTU1NTU1Y2JlNzg0IGluIG9iamVjdF9uZXcNCj4gPj4gKHR5cGVuYW1lPTB4
NTU1NTU4MzU2YTEwICJ4LXJlbW90ZS1vYmplY3QiKSBhdCAuLi9xb20vb2JqZWN0LmM6NzI2DQo+
ID4+ICM3IDB4MDAwMDU1NTU1NWUyZDZiZSBpbiBxbXBfcW9tX2xpc3RfcHJvcGVydGllcw0KPiA+
PiAodHlwZW5hbWU9MHg1NTU1NTgzNTZhMTAgIngtcmVtb3RlLW9iamVjdCIsIGVycnA9MHg3ZmZm
ZmZmZmQ4ODgpDQo+ID4+IGF0IC4uL3FvbS9xb20tcW1wLWNtZHMuYzoyOTANCj4gPj4gWy4uLl0N
Cj4gPj4gDQo+ID4+IEkgYmVsaWV2ZSB1c2luZyBxZW11X2FkZF9tYWNoaW5lX2luaXRfZG9uZV9u
b3RpZmllcigpIGlzIHdyb25nIGhlcmUuDQo+ID4+IENvdWxkIHdlIHVzZSBVc2VyQ3JlYXRhYmxl
Q2xhc3MgbWV0aG9kIGNvbXBsZXRlKCk/DQo+ID4NCj4gPiBIaSBNYXJrdXMsDQo+ID4NCj4gPiBU
aGUgcmVtb3RlX29iamVjdF9tYWNoaW5lX2RvbmUoKSBub3RpZmllciBleGlzdHMgc28gcWRldl9m
aW5kX3JlY3Vyc2l2ZSgpDQo+ID4gaGFzIGEgY2hhbmNlIHRvIGZpbmQgby0+ZGV2aWQuIFdlIGNv
dWxkIHNldHVwIHRoaXMgbm90aWZpZXIgVXNlckNyZWF0YWJsZUNsYXNzDQo+ID4gbWV0aG9kIGNv
bXBsZXRlKCkgaWYgeW91IHByZWZlci4NCj4gDQo+IEkgZ3Vlc3MgdGhhdCB1bmJyZWFrcyBRT00g
aW50cm9zcGVjdGlvbiwgYmVjYXVzZSBjb21wbGV0ZSgpIGRvZXNuJ3QgcnVuDQo+IHRoZXJlLg0K
PiANCj4gQ2FuIHlvdSBleHBsYWluIHdoeSB5b3UgbmVlZCB0byBkZWZlciBjb2RlIHRvIG1hY2hp
bmUgaW5pdCBkb25lPw0KDQpXaGVuIHgtcmVtb3RlLW9iamVjdCBpcyBpbnN0YW50aWF0ZWQsIHRo
ZSBQQ0kgZGV2aWNlIGlkZW50aWZpZWQgYnkgby0+ZGV2aWQgbWF5IG5vdA0KeWV0IGV4aXN0IGJl
Y2F1c2UgaXQgYXBwZWFycyBsYXRlciBpbiBRRU1V4oCZcyBjb21tYW5kLWxpbmUgb3B0aW9ucy4g
QXMgYSByZXN1bHQsDQpxZGV2X2ZpbmRfcmVjdXJzaXZlKCkgbWF5IGZhaWwgdG8gZmluZCBpdC4g
RGVmZXJyaW5nIHRoZSBsb29rdXAgdW50aWwgbWFjaGluZSBpbml0IGRvbmUNCmVuc3VyZXMgdGhh
dCBhbGwgZGV2aWNlcyBoYXZlIGJlZW4gaW5zdGFudGlhdGVkIGFuZCBjYW4gYmUgZm91bmQgdXNp
bmcgcWRldl9maW5kX3JlY3Vyc2l2ZSgpLg0KDQo+IA0KPiA+IEkgdGhpbmsgcmVtb3RlX29iamVj
dF9tYWNoaW5lX2RvbmUoKSBzaG91bGQgcmV0dXJuIGVhcmx5IGlmIG8tPmRldmlkIGlzDQo+ID4g
TlVMTC4gV291bGQgeW91IGxpa2UgbWUgdG8gbWFrZSB0aGlzIGNoYW5nZT8NCj4gDQo+IFNob3Vs
ZCBkZXZpZCBiZSBhIFFPTSBsaW5rIGluc3RlYWQ/DQoNClFPTSBsaW5rIHNvdW5kcyBsaWtlIGEg
Z29vZCBpZGVhLiBIb3dldmVyLCBpdOKAmXMgdW5saWtlbHkgdG8gcmVtb3ZlIHRoZSB3YWl0IGZv
ciBtYWNoaW5lDQppbml0IGRvbmUgZnJvbSB3aGF0IEkgY2FuIHRlbGwuDQoNCj4gDQo+ID4gVGhh
bmsgeW91LA0KPiA+IEphZw0KPiA+DQo+ID4+IA0KPiA+PiBBc2lkZTogd2Ugc2hvdWxkIHByb2Jh
Ymx5IGNoZWNrIGFsbCB1c2VzIG9mDQo+ID4+IHFlbXVfYWRkX21hY2hpbmVfaW5pdF9kb25lX25v
dGlmaWVyKCkuDQo+IA0KDQo=

