Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C060A261C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=lpDhGGuW;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=R+QCXKPJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThZt-00033H-Iu; Wed, 18 Nov 2026 10:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1xThZr-00032u-14
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:28:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1xThZo-0007iI-VD
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:28:02 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIE3WxE3286438; Wed, 18 Nov 2026 15:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uIEodNZrz3ndTLqSJBqjDPXqMqFi7DAsnOJB1DZfS3g=; b=
 lpDhGGuWlgGvOiGk9jbpabaIqAw6udsVoIUCXbWSD4A0X32sn3BrduBZWZN70WVl
 +c6LRhSruRZojMQ00LQQfHjuHGmKdgFIXSjdxmSjUP8F895Zy1AmWT2t+RSD6YNM
 WaGHGsPoDo82c9flPi/skdO/W4lkHCxignM44EtYtzrrJmcMhrsaRwiaIIfUwnMK
 9AdkxMC+r8a77wGARYGl6W64KJaZ9s5OZO9rP+Uh/HFi2wBpG9Sz8DkhoGjI5+24
 sNOoXS1J2U5R3mhZeVeVHRRA6cshoG189bxXwPExTE6wNCQliEvnhv2JJjDSp2B/
 yzTwZszMSHdxCjUvuTXiAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytq17d7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 15:27:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6AIEWd5W2820363; Wed, 18 Nov 2026 15:27:51 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4j1dvgt687-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Wed, 18 Nov 2026 15:27:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqT+B5dUqFwwUEJBqO/oMrJ//Cxwys7vyhq8B0S9liFzg/mKw+YkNBS76GsG9os8kFqO/xmMb481wrUgumkzGGUFgBnW+oOgyFY+/ZdVWETw6AwvnUaUrI7C1wKTwMDFDGtMm2jqkdOTkF+B399xFeLfAiWdMshYmRY2mQQwPOWxvN1rkcm3P3YSKnrFUZ+NYM0VCFwYSxJRycZiQGt3hmdbeeRm6Sht/B9c6O5N7zREC0PdRem7TDanG1Zsgxjm/eM4YWRQuDXQkdFkc27uWpTXZJp5P3E8w/pmLZVR8071GYMm53lh9AVck6G51SldFg9st12mYYvjKmKw+QOhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIEodNZrz3ndTLqSJBqjDPXqMqFi7DAsnOJB1DZfS3g=;
 b=OclKSxiqAJjZG7d6W0IYmfWMXE0nogoGOAtXxUZQ1M14rZD3EaKsHvcI7hi6Hpy9x9nOFWhPW8iHS5+4ETQBVwz4vyBSWKP+2q73qbWPwkjtxGKs3moSgh9bWRs4d3G/wexjKdly0/cDZlyHO7DF0he4fQnionW6biKGFvxVGu410HmDl8Pkih5GLEgRawoE3JuFkhA5y8GVCcbwMlOK3oYgU6XK1qR1Pt6pLpgSxylKE2KUzFPveEzMyNUR3pE4d4GMtoB1G0LJEoF13yflC+nrTGOSLeUaX18dnIZw6G3N3moS5b08nXR0dHdsXDY9+ab5URWDyShajFxJpokkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIEodNZrz3ndTLqSJBqjDPXqMqFi7DAsnOJB1DZfS3g=;
 b=R+QCXKPJ2YvLAqOmqGQq53FSgfpp+L14BC34xgmZkxrv6GkfRZZe+q1OBUPX9ckpjul8qRWHt+20xB+EPeonNYblajBvgV9JuCREzHafAJvre6+PVrWdXOIjxZFtehyJD29XktLeFhoVTwFeqhA9ooKJXKlM3jgqLRzVLrbzdbk=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by IA0PR10MB6795.namprd10.prod.outlook.com (2603:10b6:208:439::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:27:46 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:27:46 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Markus Armbruster <armbru@pond.sub.org>
CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: x-remote-object breaks QOM introspection
Thread-Topic: x-remote-object breaks QOM introspection
Thread-Index: AQHddqQgs/w8PeOnp0mHoXFGgyjw4Lcz9WwA
Date: Wed, 18 Nov 2026 15:27:46 +0000
Message-ID: <E30ADD82-0779-4294-B235-D27FD379C9D6@oracle.com>
References: <87jymbjyia.fsf@pond.sub.org>
In-Reply-To: <87jymbjyia.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.4)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|IA0PR10MB6795:EE_
x-ms-office365-filtering-correlation-id: 58d06244-601f-40bb-b523-08df45887f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|18056099003|261009223027099003|260925021911599003|260925021311599003|260925022911599003|56012099006|261102123227099003|10067099003|261026121527099003|261022105027099003|261021121427099003|261028144727099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: ptac1V8asPDyOn/IffsLSVcNUNXQ++zvUDMhYq2ga0bV6BLj7+qIQjY1xckjnj8VtgX+xqHWXERRRnrw9Ema+PgG62tOfUykAnrZkUM3tIjbRvcmBc5AQtQhtRm3ubPRkuE2d0aVYAXBFJ0ZrwmpuH+2WcBI0vVb3NViMToqE/6Aonkw1NfLsUXtX/w+P/Ts0/8t9lkxXd6kN5i/WucnMz6ciMccEjjNWHwHxDWloYR5IrhYg9rSy9ERB3NxaxZMTVHt0vQ0jbhg5Mk0MY1ppyveOp6gBOT/uquyT3Csh1XlFrKVs+CXQ4ykT6z1dayaqlbY6zZxMWHjK+j6pw0/TYVtT/Sca9TMkb2rTqLodhQPVnnF6m6WoJ5NVPTThRGkTTIZFG3sWbxulCq7DPMrJ92VIqm1sGv4AvlNRktWzt393aKocB+BAteyBIZCqI8WedS7rcj38i6i80CfYI1RhgR3DuWr6fkUWLQfQVprYRyNQuRnHbEK9bTF2/MNCePCQuMyCP/nfFULoE2HYjYgV8agrH0DK85NdY8VN8tlNvv2AxfHMDQecuVIVeOWhljJgLYqi6s5grPRRuaB6dpZc5e+9pAHx6oOxMwKYL6p2qh6ycVT0VA39C/5lxZ43YW4oxCRqnG3vnHlowle81axaxfDunZJOxlHJxEKbbfY//8su76vdr5jSgoPpczVPDJ3dkfBDCrgAE/218cJ3hMDedFsUaZEGgvmr7CIX1G3yio=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(18056099003)(261009223027099003)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(261102123227099003)(10067099003)(261026121527099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkxqeXNkUlY5VkFpR0xQUjhRaUE1L2lWZXFDMGhlSXJaYnZjSWw0NGRVOHBK?=
 =?utf-8?B?WTIrL1RjTzN3OXJjWk9LYjZnSDhqZXkyTUlTMzFsZ3FqN2lLWDRsbjFLWUZu?=
 =?utf-8?B?RXpwdm5na1VFZHlYbGdJTkJ6a0dnL2QwOWhsSk52VW1SV1BFV0o1Sy96NjdN?=
 =?utf-8?B?Qi9EZS9GaENndGVYV1Y0VWs1b0hUemVTakpVSWVEekZRVDZSNDU5UUVpL3Bs?=
 =?utf-8?B?VmR4SVFTV0RSbnp0Um9xSTFsallPS2oveGk4OEtVcXpwRjFtMWUrci9WZ1dB?=
 =?utf-8?B?WCtRaUlsRjV3amlJRFNTa3F0Y1VmYWtWaUd5eWsvQllaWnkrMng3V1Z2U1ho?=
 =?utf-8?B?bVpMc0hQTFBEYnJVclZwZXQwNjNnd1d5MkhMUmgvOXMwQis1emVuL2tWd0h1?=
 =?utf-8?B?ZWc0UEdkZ0JnRndUQ1pRVWRvSFYzelZiWjFRY3RRc0JnS2xLZUNndlpsajgw?=
 =?utf-8?B?cmNCS3dabXNqWDdvK2lqV2ZadFV0LzhJR1dxK3Z3S29yM3R1TWJqelZFd0hZ?=
 =?utf-8?B?NjYxcm9DRHFmU1k1ZzRPais3bkh6NUhoNjRPZkpUdnpNSlRNWVJWeVV0NURP?=
 =?utf-8?B?UkFvQWtHMDczRmRSOFVIdWV1T1BDQ3kzY05JREdVb21Ob0lPSG5BUHUyYnhZ?=
 =?utf-8?B?cFk0QXdmYXN1eFIwdFREMmFlWitWSTFnN3kyZ2RVaWw0cEMrOFlkaUdkRk1z?=
 =?utf-8?B?RzhwUlFIcUFyM2J1VTJtNHArOHY2N3FYYVZzT2FlbGNQZ0ZGR1ZXMDBXRm9I?=
 =?utf-8?B?S0pNRjdLRm9NQmJxa2ZicUREVWFaZk5SWnlxS0NUaExXQ1pCK3lYd1RLRGtm?=
 =?utf-8?B?RW5qSWtQM3diMXR1NzhFVnVwZEdqRk9pdVRmMjZSMHNXVXFpQWZzNFRHODNX?=
 =?utf-8?B?U3J5UnpFaElrSDZnd2M5dFNaQ01rWGNaYzZyKzRMVisvT29nWEhWakRpYUVN?=
 =?utf-8?B?YUp0YTdqbDhEMytmVk5PUUQ2SStuNE4rWFhCekZ6Q25qOXRHWTc4d3JIUHR1?=
 =?utf-8?B?ay9xYlNLRXMrSlhTN0ZmbmJtMStYUnBYS1p1OFRoT3I3VnVUYWVqNnhmL2ow?=
 =?utf-8?B?MTY0RHJQbTlGOWxsMnVuSFdsWGFGRW5BcEcraUZFdHpaUEVYVWFXLzQxdU90?=
 =?utf-8?B?UXgrL2d5SUJYZEMxMWJiTE40dDRxakVyRUo2NENGRHdNdjBUSVRjUExsbkhV?=
 =?utf-8?B?SkI3Q0RlMnQvWmFpdlBoUnhpamI5cEo2U1d5OFpQV2hUU2tQTmZwT2JUQnEw?=
 =?utf-8?B?ZTBCbmxVSVZqMWFhR1lpV1hMVE5xaFdVWFk3eUdIb1laYTR2ZEtmNGxGUGlr?=
 =?utf-8?B?UEVpL3BJRkFzaHB3U01vaHhjUWpCQTlFUHpsZGxxN3l0SGNBSUhBcTZKcGdv?=
 =?utf-8?B?N1lWNnRXcU1ybGF6SCtremx3OWlkNHNsOUlHWXhjR2tNekJGVEtnb0t2V3o0?=
 =?utf-8?B?ZVhzMktwN25haU1RQVIxV0IySDM4NDJoQU9RdDRRVEcrNEVmcWxUb2pXWmRo?=
 =?utf-8?B?Zmo2Q0p3QlRzbjdRQ2ZlWXZVeU9iUjlWM2MyZE5SL1pBT3A5NW9HQm9jMHJW?=
 =?utf-8?B?emsrbTVDTGxpMmU5TFlwKzlOcU5TS1J5Q0s5UkhDbHZhbnJnR1V0VjBlM01Z?=
 =?utf-8?B?alVrU2h0eFdaSGs2SDZIME9FT3ZwSUN1NHdpWmNZWWRjeFJXU2lERTF2UXpC?=
 =?utf-8?B?bjNYOXVzUFB0SktJYkpPTDUxdm02R2VVa3kzaXBsOElkWmdXMzZydHkwNlg0?=
 =?utf-8?B?QWtySVZWdGFGa3BTOFNxV1VxckQ3Mk4wSVlCY0Nldy9OSUtheHo3MFpNR1Fx?=
 =?utf-8?B?TGF6U3ZtVEhwZHdTWmRMTDlwZHVZZmhBTTViWTc3N0pKZUpENER4ODNHcXlO?=
 =?utf-8?B?SUNKbU1QNkxDMytxK1ptc0IrQU9XcWgyK0hpRm5yMXhFbjRkZytxcE8rbWZN?=
 =?utf-8?B?WGdTWXM4TlcrUkJ5OXptdkNPU01rN2VzbGZWRVhGUDJFVzRBd3d4dDNyT2VB?=
 =?utf-8?B?YWRleWUxQlRlelJXa2Q4SEFpWEFIOUdRdHFudDhKSzZIMXEwZjMyS1RIZWNm?=
 =?utf-8?B?K3dzaVFGRDF0RDF6QndaQTFYYjVnb2Y0M2dUQkRZTHpST3B6RVFML1ArWkFU?=
 =?utf-8?B?S0d4NkZidXZEaWMxT0xoZS9kcDJBbTZUTjJoWWFQL014MlQ5eTY3b2E1T0J4?=
 =?utf-8?B?VHRydUlaRXg0UnRGZ3JHNlN3SGdlblBDbkgyc0w4YnhyQnd1Nmg0eVNYUXM4?=
 =?utf-8?B?VkNuNWRleUtzdGRsQXFPRzZHSit1RldBRVJ3Qlo0QkNGbnAwaWRxSUpLMEpl?=
 =?utf-8?B?Wi9lT1VHbDB5bFhxdjN6T09pTFQrNVdOY1JjRVpvVmFyTEhGWDZyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <626F108F47AD9E4EB1C6F24DE46F8305@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4KYT6xj+OPJLhFfRO7qm2BEyvO8MBSe8hcHlA5b38ANLL6DUnpXt98+Q0pu1/vQvZFSNDPEAySOc/qs5Oki7FRCyPjYn0lSCQaHyRb5dFAo1s6F7/aA2xj0CsS0IuF9aoLwEK2SuETIChHxEOclCWe8e2v2JNIbZXdVo7xV6Mw8jjedcErjWlyKDyMtSy5O7e/Ju2l+xbBL/3ARvPZpYcqa+WyaTaDcr7CnPobSDNyq8d6d6kgqsxRVhF9HjB91MPPj44RW5MNm2kw7eaOGMvfZ96omE8a5CLVfUX7Fvww8lLKkrLGXpz7KScVqsmlAxKKov0ieLc0dL9kIzUdNw8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 34cFAon4TauvlEWOnEnb3oo4rnSTbxvVODLTcqgBLRDEsqQ1zUjrgex5IVMDLSf2hk7n5qv2VJQKrWScojloxPG7T9C5qAXkM/vzbmJ0VI+7jukOxMAXjVVFhNbG4OdHj9fCwc3gr0FDTEwNKkkMAM5H01jxL/DjzpgsuYyT+GjqisbCDYN48Ja8fmFEtloaAe3fManSLVfLOalRar26RxCBG8QQ+09sUueWnV+/tJ1aE8LE1nvc9oFSO3KjmgpUrQHmJhEtDmW9xbGuQClpy++ACojgUspeSfAWWIwXQr1k32mfRVLxVjM0LQKdgcoiysD3TYLxW9k9/WhUsEijHuM+w3eg6ZW0/2PC7l4ew4fI81Un/+i3xP382lk+s95GrcvPEdoSk2nD6GAS1XQwdgKUDkxi6t8RcFpdzhR98EoRkZf15sqeN7wL6aSTdHN8CfQH3ZE3zKtBaoivTRMdzXFZ8QNFzZKjS4N/VmSD4d9u6OYkUsUWxc3F2M0zI5yE0GPLoImV2MalrwJWD7VPgcDmvU7VeHiaEK8+KqhDUmO2MU7qjfd7VvGoTkgLDeoiT/SQmWGRG9UNoKiCbznrqjb5WRYQxnyx85G/+5qeS9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d06244-601f-40bb-b523-08df45887f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 15:27:46.2629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6Va4hCcpHS/nRDdPbk33V57Xd8iVoVk2Mzt8WApqj1zQbAXutjU7xgu0CrbAqBhOrKOf7Ths6QFW2bU1vMyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611180061
X-Proofpoint-ORIG-GUID: RmPiS6bZUMjRxWCUR-pLNWLQqigQ95NG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX7G0qxuatvLxY
 NqiIyojrOYCIaa7ByDNZLaLImyiZjWOFw69o7/rb4FYsPB8clKdGsYfx8k2mEs5WAaWRLhI+3eF
 vfFYfzQppPJhynUAD36Ac40TajLaBB1E2M+yA7dBghyTRA3xSamv
X-Proofpoint-GUID: RmPiS6bZUMjRxWCUR-pLNWLQqigQ95NG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfXzBDbfEv0J7Tt
 u6FuYT6VQlw+8qxWF35iXQ2NeQjzRbpjlY4iVL2WNNQG65SiDNVN5VV9QuqecrxbPRJeOBVRjwy
 VVPFSFTA5HeX8nQVZ4BfBgot0/apv4kISUsbt6G1snvH41PR8qNlpN/uXhdVVWA5aoELYUeAjEH
 ftcsD94U0t8bd91fTc4tgljSzGozt4jrs5TZ+Y3h67KdKDcfqGkimgH20S2LTmExb4tsX5m3JZg
 4jWhgGBlcuZRKbShJl5VL59WIknp8g4S4CmX1ZFjH8zFcwFIi75ImoU1N7QX1ZSZmI8THhqI442
 vHST/flqqET25EfCp7BZ3PIfLPOMq4NdbQ9JYpk5AMxBVA9QqMv3sW9/+tDKv3IRdg3s4gh3sM9
 esHKH9GN42swtH0m418ms6ZivM0EACHapvFfgGskjAFJzjNyky2rUu1kHwZI6n5dZ24Dhovvx55
 RoUEaB9kdrpVX/sGseg==
X-Authority-Analysis: v=2.4 cv=I+vw19gg c=1 sm=1 tr=0 ts=6afdc3f8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=ZiMIAIO6AAAA:8 a=Z549faNCznb-t3TGIasA:9 a=QEXdDO2ut3YA:10
 a=KohFQSMcaiS2QNUyYz07:22
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

DQoNCj4gT24gTm92IDE3LCAyMDI2LCBhdCA5OjU44oCvQU0sIE1hcmt1cyBBcm1icnVzdGVyIDxh
cm1icnVAcG9uZC5zdWIub3JnPiB3cm90ZToNCj4gDQo+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGEg
TmV3IFNlbmRlcg0KPiBZb3UgaGF2ZSBub3QgcHJldmlvdXNseSBjb3JyZXNwb25kZWQgd2l0aCB0
aGUgc2VuZGVyIG9mIHRoaXMgbWVzc2FnZS4NCj4gUmVwb3J0IFN1c3BpY2lvdXMNCj4gV2F0Y2gg
dGhpczoNCj4gDQo+ICQgcWVtdS1zeXN0ZW0teDg2XzY0IC1TIC1ub2RlZmF1bHRzIC1kaXNwbGF5
IG5vbmUgLXFtcCBzdGRpbw0KPiB7IlFNUCI6IHsidmVyc2lvbiI6IHsicWVtdSI6IHsibWljcm8i
OiA5MCwgIm1pbm9yIjogMSwgIm1ham9yIjogMTF9LCAicGFja2FnZSI6ICJ2MTEuMi4wLXJjMC0z
LWczODE3MWY1OWNjYi1kaXJ0eSJ9LCAiY2FwYWJpbGl0aWVzIjogWyJvb2IiXX19DQo+IHsiZXhl
Y3V0ZSI6ICJxbXBfY2FwYWJpbGl0aWVzIiwgImFyZ3VtZW50cyI6IHsiZW5hYmxlIjogWyJvb2Ii
XX19DQo+IHsicmV0dXJuIjoge319DQo+IHsiZXhlY3V0ZSI6ICJxb20tbGlzdC1wcm9wZXJ0aWVz
IiwgImFyZ3VtZW50cyI6IHsidHlwZW5hbWUiOiAieC1yZW1vdGUtb2JqZWN0In19DQo+IC0tPiBx
ZW11LXN5c3RlbS14ODZfNjQ6IChudWxsKSBpcyBub3QgYSBQQ0kgZGV2aWNlDQo+IHsicmV0dXJu
IjogW3sibmFtZSI6ICJ0eXBlIiwgInR5cGUiOiAic3RyaW5nIiwgInFhcGktdHlwZSI6ICJzdHIi
fSwgeyJuYW1lIjogImRldmlkIiwgInR5cGUiOiAic3RyaW5nIiwgInFhcGktdHlwZSI6ICJzdHIi
fSwgeyJuYW1lIjogImZkIiwgInR5cGUiOiAic3RyaW5nIiwgInFhcGktdHlwZSI6ICJzdHIifV19
DQo+IA0KPiBUaGUgZXJyb3IgbWVzc2FnZSBpcyBzdXNwaWNpb3VzLiBPcmlnaW46DQo+IA0KPiBz
dGF0aWMgdm9pZCByZW1vdGVfb2JqZWN0X21hY2hpbmVfZG9uZShOb3RpZmllciAqbm90aWZpZXIs
IHZvaWQgKmRhdGEpDQo+IHsNCj4gUmVtb3RlT2JqZWN0ICpvID0gY29udGFpbmVyX29mKG5vdGlm
aWVyLCBSZW1vdGVPYmplY3QsIG1hY2hpbmVfZG9uZSk7DQo+IERldmljZVN0YXRlICpkZXYgPSBO
VUxMOw0KPiBRSU9DaGFubmVsICppb2MgPSBOVUxMOw0KPiBDb3JvdXRpbmUgKmNvID0gTlVMTDsN
Cj4gUmVtb3RlQ29tbURldiAqY29tZGV2ID0gTlVMTDsNCj4gRXJyb3IgKmVyciA9IE5VTEw7DQo+
IA0KPiBkZXYgPSBxZGV2X2ZpbmRfcmVjdXJzaXZlKHN5c2J1c19nZXRfZGVmYXVsdCgpLCBvLT5k
ZXZpZCk7DQo+IGlmICghZGV2IHx8ICFvYmplY3RfZHluYW1pY19jYXN0KE9CSkVDVChkZXYpLCBU
WVBFX1BDSV9ERVZJQ0UpKSB7DQo+IGVycm9yX3JlcG9ydCgiJXMgaXMgbm90IGEgUENJIGRldmlj
ZSIsIG8tPmRldmlkKTsNCj4gcmV0dXJuOw0KPiB9DQo+IA0KPiBvLT5kZXZpZCBpcyBudWxsLCBk
ZXYgaXMgbnVsbC4NCj4gDQo+IEdsaWJjJ3MgJXMgc2hvd3MgbnVsbCBwb2ludGVyIGFzICIobnVs
bCkiLiBUaGVyZSBhcmUgbGliY3MgdGhhdCBzaW1wbHkNCj4gY3Jhc2guDQo+IA0KPiBTdGFjayBi
YWNrdHJhY2U6DQo+IA0KPiAjMCByZW1vdGVfb2JqZWN0X21hY2hpbmVfZG9uZSAobm90aWZpZXI9
MHg1NTU1NTg3ZDE3ZTgsIGRhdGE9MHgwKQ0KPiBhdCAuLi9ody9yZW1vdGUvcmVtb3RlLW9iai5j
OjkzDQo+ICMxIDB4MDAwMDU1NTU1NTc4NzAwZSBpbiBxZW11X2FkZF9tYWNoaW5lX2luaXRfZG9u
ZV9ub3RpZmllcg0KPiAobm90aWZ5PTB4NTU1NTU4N2QxN2U4KSBhdCAuLi9ody9jb3JlL21hY2hp
bmUuYzoxNzIxDQo+ICMyIDB4MDAwMDU1NTU1NTZmMjZkZCBpbiByZW1vdGVfb2JqZWN0X2luaXQg
KG9iaj0weDU1NTU1ODdkMTdjMCkNCj4gYXQgLi4vaHcvcmVtb3RlL3JlbW90ZS1vYmouYzoxNDkN
Cj4gIzMgMHgwMDAwNTU1NTU1Y2JkYTJkIGluIG9iamVjdF9pbml0X3dpdGhfdHlwZQ0KPiAob2Jq
PTB4NTU1NTU4N2QxN2MwLCB0aT0weDU1NTU1NzdjMDJkMCkgYXQgLi4vcW9tL29iamVjdC5jOjQz
MA0KPiAjNCAweDAwMDA1NTU1NTVjYmRlMmMgaW4gb2JqZWN0X2luaXRpYWxpemVfd2l0aF90eXBl
DQo+IChvYmo9MHg1NTU1NTg3ZDE3YzAsIHNpemU9MTM2LCB0eXBlPTB4NTU1NTU3N2MwMmQwKSBh
dCAuLi9xb20vb2JqZWN0LmM6NTEyDQo+ICM1IDB4MDAwMDU1NTU1NWNiZTZmYSBpbiBvYmplY3Rf
bmV3X3dpdGhfdHlwZSAodHlwZT0weDU1NTU1NzdjMDJkMCkNCj4gYXQgLi4vcW9tL29iamVjdC5j
OjcxMA0KPiAjNiAweDAwMDA1NTU1NTVjYmU3ODQgaW4gb2JqZWN0X25ldw0KPiAodHlwZW5hbWU9
MHg1NTU1NTgzNTZhMTAgIngtcmVtb3RlLW9iamVjdCIpIGF0IC4uL3FvbS9vYmplY3QuYzo3MjYN
Cj4gIzcgMHgwMDAwNTU1NTU1ZTJkNmJlIGluIHFtcF9xb21fbGlzdF9wcm9wZXJ0aWVzDQo+ICh0
eXBlbmFtZT0weDU1NTU1ODM1NmExMCAieC1yZW1vdGUtb2JqZWN0IiwgZXJycD0weDdmZmZmZmZm
ZDg4OCkNCj4gYXQgLi4vcW9tL3FvbS1xbXAtY21kcy5jOjI5MA0KPiBbLi4uXQ0KPiANCj4gSSBi
ZWxpZXZlIHVzaW5nIHFlbXVfYWRkX21hY2hpbmVfaW5pdF9kb25lX25vdGlmaWVyKCkgaXMgd3Jv
bmcgaGVyZS4NCj4gQ291bGQgd2UgdXNlIFVzZXJDcmVhdGFibGVDbGFzcyBtZXRob2QgY29tcGxl
dGUoKT8NCj4gDQoNCkhpIE1hcmt1cywNCg0KVGhlIHJlbW90ZV9vYmplY3RfbWFjaGluZV9kb25l
KCkgbm90aWZpZXIgZXhpc3RzIHNvIHFkZXZfZmluZF9yZWN1cnNpdmUoKQ0KaGFzIGEgY2hhbmNl
IHRvIGZpbmQgby0+ZGV2aWQuIFdlIGNvdWxkIHNldHVwIHRoaXMgbm90aWZpZXIgVXNlckNyZWF0
YWJsZUNsYXNzDQptZXRob2QgY29tcGxldGUoKSBpZiB5b3UgcHJlZmVyLg0KDQpJIHRoaW5rIHJl
bW90ZV9vYmplY3RfbWFjaGluZV9kb25lKCkgc2hvdWxkIHJldHVybiBlYXJseSBpZiBvLT5kZXZp
ZCBpcw0KTlVMTC4gV291bGQgeW91IGxpa2UgbWUgdG8gbWFrZSB0aGlzIGNoYW5nZT8NCg0KVGhh
bmsgeW91LA0KSmFnDQoNCj4gDQo+IEFzaWRlOiB3ZSBzaG91bGQgcHJvYmFibHkgY2hlY2sgYWxs
IHVzZXMgb2YNCj4gcWVtdV9hZGRfbWFjaGluZV9pbml0X2RvbmVfbm90aWZpZXIoKS4NCj4gDQoN
Cg==

