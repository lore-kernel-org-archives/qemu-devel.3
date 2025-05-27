Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E3C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuIX-0005Uc-FL; Tue, 27 May 2025 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJuIR-0005M0-I5; Tue, 27 May 2025 09:24:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uJuIM-0000SA-D4; Tue, 27 May 2025 09:24:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjfMa011709;
 Tue, 27 May 2025 13:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=xos9EyibD83G0Hcny0YJj3dScfJuB0c919hXSIXhJJU=; b=
 qezzlZjbOhpRD1xwUjDTLjQJ1D+KzqcWPigryStlayFMRGAxIIOdguxIoiLHcJKX
 lpgCrG43eTKx7dIU7VKv8BAxOHddOFcPkkFhFioVL6QUB3bTfaQLUk/Xezro6f2I
 I+jV4+iAPK6QXohvIt5ANocPWTa+/Y2RUZqkYB3qAz2dbiU2Iz45XRHbp9rJD3Uw
 V9X5gok4acHHH5DzSbhd8WsptQ3An+9/1kXYZ7ijzR1YvjzzRlpXaZiYAgqTmyqx
 2xG7IfTzoe4Twfq9lDQPkek+1eMk329tyzbrEm7A3Hy2TIWW15bxCMPfD9J/jAUI
 1tenuW7Sm2z9zKmUhzqkEQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2peu35v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 13:24:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RDJwEN007479; Tue, 27 May 2025 13:24:34 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4j93tnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 13:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqaGyt0CNec7+RpMMRT0fMmJWgtPE8dc8q7mCNLTmNLHs+vu0IwN6u7trZgjrVPCWRIu2KIQkVFEszkTQQzE12WcwrsGGswDaGq+AnJVnbVo5qSIIIcBSnNt6QIMAVLc+TQ6wusApt1USmiRGFUUf2GL9m+1w+dpjVT9YfE5RA+AZ315e0q99t5LAQXnk6b95TW1wLOT30MECYqztVTPmg7b1ULQ69EWHhzdsUtVlkUDnqgvHYk8hgh6IO1WUNeASHUmNS1gWAFTlOkjVoPIifu4Mq2Vf51Mn2XyvGwyr4BIcjFBdo4cituKWSihTTvAcD3mNyvdcfMcxlm6SeY2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xos9EyibD83G0Hcny0YJj3dScfJuB0c919hXSIXhJJU=;
 b=tNoshqgsfMATilDbTb1ne8Wj3uKaL+nqlmpvdCrs9/zwGR37n0v5maat7hsZg6PlWn0c+rSVu4XAYLV/M+lf2O+fm2j29n7fdXKyAd5sC3JLsH4+Tdlw+u3DKlVZcSktkCwbn2Zfwgq7F2VWWEEb7gXBId5dugrpdYZIYppC517vvR7Opiemj2ko4bEFlMyoSPjmhKAhU20OLc6mFs2ntK5SEhX6MPip64/3+9s2m7/vCEg8HGwRTzPivm7LMpALSoEvdGYKtVrWU0WCE7NjUoZiIpoga/SeWppn9Ubalh1EDw2BWuuVzxknSDYNKwzJEEdbAOwjUjmnfTr6mvkiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xos9EyibD83G0Hcny0YJj3dScfJuB0c919hXSIXhJJU=;
 b=SxLUsD5vhfAOiTmPkFUDqvULwnO4BglS2DC+7jE1Y3yil7v+GDdlydc95Jv7dnRbtKRkgEUKQBO8Iz+KLWQpPOMW4BFF+JwuN/sApURvs5NMUIXQF3j48nZr67frggrc45BUg+b1hzKILi9o+YOtt2tIk/oZmcyExJkxgRE+esk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB6494.namprd10.prod.outlook.com (2603:10b6:806:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 13:24:31 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 13:24:31 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Marc Zyngier <maz@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "gkulkarni@amperecomputing.com"
 <gkulkarni@amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmF3GAgABDNICAAAY4gIAAFtEA
Date: Tue, 27 May 2025 13:24:31 +0000
Message-ID: <A5135210-4984-4532-B0AF-9CDC8255CBD0@oracle.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
 <63FE2592-DF4D-4CCF-BC76-D8656C9EFA0A@oracle.com>
 <86jz62dzxa.wl-maz@kernel.org>
In-Reply-To: <86jz62dzxa.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SA1PR10MB6494:EE_
x-ms-office365-filtering-correlation-id: b844272a-3aaa-4d82-d8a4-08dd9d21d094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lyhdci82ZMz4XsCt+wBMyf0ajD+S+8fKRq0pY6bmftuv92HxKJ9hSbLFSq+I?=
 =?us-ascii?Q?mdEHQGuO9X1T7yoAHBISeC12LomHOUMYYOcMUyrV58XHb25PsVGMx9JSLNlB?=
 =?us-ascii?Q?4l9qFA9BFOgeBZhKAlU+CkfUGdsGRaNiJqI4A1t2Acb6nnXafdN9dJEPuIY4?=
 =?us-ascii?Q?gnV66kaZgadc8MNQ30DjQvs7RRfaC5aIhRqVs9GdwGNWUldUVzQe1u3tnuuH?=
 =?us-ascii?Q?RQwrTWGWeiglxmWpo+2ivb4F8G9Dq0mGEsJc2vPQklN7hTjpBFy1CBt6gHiJ?=
 =?us-ascii?Q?Zw2XMHqG9lqnEXLoIOx8gm98dpKDf5L4jGtmM8JcZKHLbpVj7M2RP5nJps5D?=
 =?us-ascii?Q?fE6KYiMdGhN4Q9CLbCqFsYOWZbciFWItq+RvhmyFIhk9meJvy02e75W223n0?=
 =?us-ascii?Q?F0w1y7oUsnLre+Kui5bky0R7aStDOQLLIYPVHWj9bZNlvNnjQ843W0fCVePO?=
 =?us-ascii?Q?xY2IInYoxzOaLqwbaZPjqLGS0ZqY47UTAK3U52+MKfe+KFRqCLLiJ7iHI80T?=
 =?us-ascii?Q?gFvrkMT7mSYeE2ZxV7J1Po276b6NlOTRK7GJ+7kX9qzZyuw5W9Tr14JZcKrn?=
 =?us-ascii?Q?AmLNxRWp/pBDp/4+asiGkF4qUJbp+FszeEmR1G5hcm72g3uH8pyec0XrpOOE?=
 =?us-ascii?Q?NwpJW+0qiX42xfaMJjDqMblH200ljxdmyctRBpJp7JDhT4zm9w2Ra+EY2DEq?=
 =?us-ascii?Q?gykl9DhhV+zoewN0nBTBuS+pRvOfOFnhiKmFeCbdE2MiawznUI7Q9yKMa+l8?=
 =?us-ascii?Q?AwXnOOFv0GkMU4KqYw4V8bmH0XGIDnNYMfMjdIyUw+onGr4aLvIxRPERAcQb?=
 =?us-ascii?Q?3ifdltfJbdKwT31J47VmzzS9fpTzdaMbmByi4UI5RgqxUBqZNhWuUFkOCl0r?=
 =?us-ascii?Q?YoOhhcitU9hUcpMbRP1xYQqzDPgQ1ubXrd1iYg9pQWLsgClPDT6CDWXqShxp?=
 =?us-ascii?Q?omgcNPGju+MYwksw9Bl6qto2E294XVa6QYqPy2gfr3a/99SRLineCRYL+Sjg?=
 =?us-ascii?Q?VoFJC7+Q7IjCk7DzENSFwvWb7Eze6zeZCE1JaXUr+ALiESjEjYlmwAdPfbCd?=
 =?us-ascii?Q?m1LMzc6p8c64TRvctA2irE6WAIESXA+rLoRzfHL/i21iBn5SIYrILPWydhX8?=
 =?us-ascii?Q?yoTvgGErFrTu012OnwhvJGlSuXvVuRxqGrNgKh9nFEBX1E95QnHrf5Qvl77z?=
 =?us-ascii?Q?YtSVxy74Qi4svDdnfljF4MzBQQuGguRUNMyd/umgy2ShtoZbipIweTG8+b/v?=
 =?us-ascii?Q?wF+/u+m6Ynl8mp+WBf5ccDKX0MPl1px1DnPxrjCYUZqR6/6JC+9pbBQBuhFU?=
 =?us-ascii?Q?xYmD3axehQFTAs/HxAT49Ykp7QJQzNL1UMLehlNQPomQHT5X93hkEqCGwA6F?=
 =?us-ascii?Q?kS7VZWLF9jAaYrM2EskZNsRJk8YRP4nCKfQiOV31ugZtofG0+0XPhG/3gwPn?=
 =?us-ascii?Q?VsFl4cPiPJ7P/rHwufHBc65DvSZeg+Sm/Z7SdN0tq3j4tILJcD84oUruK99I?=
 =?us-ascii?Q?SVWp2mDM9KpE5V4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X3yFXh863+uowOduT+48NHW2+qLeshJbDA0Uyn4z4cL9HiPyMQ/KqMY0b1OU?=
 =?us-ascii?Q?/lxzMvEhPUTDFwoUQTxjxL6gEiQ70L4jIJryzMFM9yXDORrbv+Rb4ZXp1If4?=
 =?us-ascii?Q?7zhP7ok8bDSoURmgGU6azP9PZTTBEZP4nLm0iAR3cE4qRiTxCgeZ5qQQHh+P?=
 =?us-ascii?Q?BVK5lwtrx8PzZcDfokaRJ6tEpTLidaxy+Kuk+bJag+/mF3oMGz8VJMqMvHk1?=
 =?us-ascii?Q?2Jnk5/VDDzhkig+UCDtaDfF3v03LyeKaCNBNtlNRJZe+nFisEdlBrTnAtS9D?=
 =?us-ascii?Q?TDp/v7XYdQwg3o/U4WGFWm3zAhEwRV+lsyPyO74Y9bCsS28ccEFIdbC4K1lf?=
 =?us-ascii?Q?0+SXkYWJO6nAVG70cmUPb2k8ulMrw3fPx/M8SVbz3YP6cY56c+xz3pZZVatM?=
 =?us-ascii?Q?5DHc/ZLbPV6cZVHARIrxUfks18xebKWMg26nUW7Hm/rFQ/PB0VDwmqyWNOUs?=
 =?us-ascii?Q?5IxS/xdXE/tBq21MtdsV1I7fry6jA2FT2Pb8dGFFA+1hXEbvPYc74AoUoO9B?=
 =?us-ascii?Q?fPpRh5uKYJwCIS+EQBymp1BMKy0ZoEf/D0RG53pu3M7EYtEYTEiYp98FHt4a?=
 =?us-ascii?Q?9lsx1yooxvXFnSraUoFvyBScf598zU8WbLh9/+h7Y+WwJ4WuBvJGQuFfrxJu?=
 =?us-ascii?Q?uqvEeuvsWXY71lzqaKu0Z9z5vWsFljRahLjRaaacKvmf0CzGjeIIkcIgAYbF?=
 =?us-ascii?Q?F80KVLUeREAdpCPvLNBxOL4hF8d5IDcdeiBrwBhVgBmEawEOmb+H8gdwsXc9?=
 =?us-ascii?Q?sy3Y6DwjBpNBdSRxUETCY+EqEZxK7txK3PhYueblkA/SAOxJ5ROXaQGax7N/?=
 =?us-ascii?Q?lRek7Oj1eBO4zwD7PPK1JIDC5o2QMqJaOPGP0uq0war9+YGv9y1TDxqhxCXw?=
 =?us-ascii?Q?mReF9z2rJQM5FBJ1iWC0ELN9ECN0u303PUU741iRrN+DSkjzU2ZfY5QpFUWG?=
 =?us-ascii?Q?NqN3FlHEgnNk6cfEaZ5z47yYLcgeW5thMU1i2MdTfcZjXKILdfuQvLxJub19?=
 =?us-ascii?Q?PkyDPlOQkaJKDoMZoG7vwGAN3cM9EkyL5pepH57l4hn9EAbSUm/m/Th9NFM3?=
 =?us-ascii?Q?Pvofcw8CnPVc+feT9C9BTlai1UG7egHp7j5q376heXwchAPKeOUHWhe5LDtw?=
 =?us-ascii?Q?KJwoy5fqR5N8x0zGXACqFc1eMehlcJpSGWDNzDFHGqaQtt3WVm0a5DJaegpP?=
 =?us-ascii?Q?nN7fv/j3eCV0NZg/4KgiD8y22YWyVuf7P/vyGOVd4YDTMRGFDFzAZdykGuky?=
 =?us-ascii?Q?JUaqaLKejEF1bF0E51ETv7paU26Vd/hc4b60prs0aEwfrZoHmOh6QYPV/tXf?=
 =?us-ascii?Q?ETQrDROOUaCkBXIOarDlfotZzCmhuK54BTS+72w2O5yfU5LoAugieElS+m5P?=
 =?us-ascii?Q?UDJetVADiTRSKzbfW9XbIyOMoCIchTa8LbcWUcRPWrs+th6bLWe0iSQjkrs1?=
 =?us-ascii?Q?YQkonDiu9KWsuA4yRlygocn+K6bbH+oYOqghWc+g6Lzy8g2H6H9+MsA9BtEp?=
 =?us-ascii?Q?9eRDoubd9egpdXu8rPed6zRutdwzliG9+P+h9rWE/pGjGiBe/eJQsVC8AJWp?=
 =?us-ascii?Q?TBCDNH2sz/4SQ4UeL4AqBjV2/ued5o7bhdpApU1BEs3C6o+3SHNjSKtZ3V1R?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0AEABC21B460F4BBAE7C66CDE90FE87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zY+OI1ineyKME0dS3eUzn1Oj/758UJJX3kMSySY7eSzun/bZUIZJlbPyFdF0VofwwdTRtcsmDAah5FOm2j05YailMNq1s0ICDmS/q2wzXUsQwuQHnu+7OM6wrHuhfjX+dUriEcM3dAdoWk62lC/okvovL5GWb5FhlqNaDvdYmtIDC9vu1BgfMGi1nBCWtnijjlH8M6TOJ4Dtwi6DQY7GTn4NyrTVpTV4OajZjnEPaPGFu7/b27Uku07nS481haIdA/2JrhVG3Z+aU7XNxjUcru6+sTxNxfIKXBp0D8UM5nTQ1LHDr88N3d/V+JrcP5NkNW6kOFLQacKaCeJX6TkBfFLCAW25NiLyJvMiuBQvPcCAhOATt/y9giONGIQ8RQicLIhR+dD0wyZfQ0OVkpkfZhDIgW91Lvrb54zdWtBSFrgTQMGr6SOn+OjoiqNJ+pOd/uCHZItZusydhmr14d5BSUsp5uEQtAxx0bSvudGZL1vetzzlzgwYvKGtEyhbEoApbajpdpr2iAF+1WfA9rppChMID0HTl0t5CGniI7ABNyEqLYd/+HakeN423AdzZ8Z5BRHgvxu6A+RppXahsM+Q5w/KeIE9yA1UWkqpDgCL6o0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b844272a-3aaa-4d82-d8a4-08dd9d21d094
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 13:24:31.4896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9L667avMfRrO5FZ05b6IJNitui1M+Ym+5u4tQyBsXGcyC9A/+4SEgjtHgJATQz06OL5yN9B5iAeP3QKwTWv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270109
X-Proofpoint-ORIG-GUID: mijTGDMP4rHbjOPH-CCrkWGL96wOZJ34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwOSBTYWx0ZWRfXwaevqjubql8N
 Ce8Z72/N2uJ1Z6TTQhTobocBsZC7bsBkEvN6P6tSet4g6qy6F8jPw7OPiTs+8hhtJnUfeHksV0T
 8RJBBbRSkogN1jY+Tu/ZAwy/4ICUzTMNnfRA96I59sI4eqP5mjXMiIYKWpYuShXBH86tNTDhdN/
 sIxmZ23u5tAXiyh5Sm8tgPErMbPxVimesf1L88tpj/7YwB0unmNUJ8uBPRStmMHdPWX6Y/y2jYD
 Jr+KWAFAA4SqRQpYIJDser9c9/e1DL7RccEZzwpX4R8/Kro5931wTv0ESt6t1HrHOZTbR3rYNLd
 zmxZcmn1X4m6KXJu3L5arUW/LZig+kQxej2yMCxVkTxfyBx3U7RIfnu+CX0LngVt0G+e4s2tZiI
 na3Oy9DJVla1eIcGCBXbHJ+8l8Yj1cedrTx9jdE9PgFMxwszuEjkSSYepqr3D89T/EPRRVdd
X-Proofpoint-GUID: mijTGDMP4rHbjOPH-CCrkWGL96wOZJ34
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=6835bd13 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=vtiTT-pQyRSrieCYKC0A:9
 a=CjuIK1q_8ugA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 27 May 2025, at 12:02, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On Tue, 27 May 2025 12:40:35 +0100,
> Miguel Luis <miguel.luis@oracle.com> wrote:
>>=20
>> Hi Marc,
>>=20
>>> On 27 May 2025, at 07:39, Marc Zyngier <maz@kernel.org> wrote:
>>>=20
>>> Hi Eric,
>>>=20
>>> On Tue, 27 May 2025 07:24:32 +0100,
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>=20
>>>> Now that ARM nested virt has landed in kvm/next, let's turn the series
>>>> into a PATCH series. The linux header update was made against kvm/next=
.
>>>>=20
>>>> For gaining virt functionality in KVM accelerated L1, The host needs t=
o
>>>> be booted with "kvm-arm.mode=3Dnested" option and qemu needs to be inv=
oked
>>>> with: -machine virt,virtualization=3Don.
>>>=20
>>> Thanks for respinning this series.
>>>=20
>>> Do you have any plan to support the non-VHE version of the NV support
>>> (as advertised by KVM_CAP_ARM_EL2_E2H0)? It would allow running lesser
>>> hypervisors (such as *cough* Xen *cough*), which completely rely on
>>> HCR_EL2.E2H being 0?
>>>=20
>>=20
>> Something that pops up is early_kvm_mode_cfg trying to handle nested mod=
e
>> while KVM_ARM_VCPU_HAS_EL2_E2H0 is set.
>=20
> Care to elaborate?
>=20

Say host is booted in nested mode (kvm-arm.mode=3Dnested) and host's KVM su=
pports
both KVM_CAP_ARM_EL2 and KVM_CAP_ARM_E2H0.

A L1 guest boots setting both KVM_ARM_VCPU_HAS_EL2 and
KVM_ARM_VCPU_HAS_EL2_E2H0 and guest kernel's command line state
kvm-arm.mode=3Dnested.

This splats the kernel from early_kvm_mode_cfg along a malformed early opti=
on
message.

This is not related to this qemu integration though, should you take it som=
ewhere else,
please let me know?

Thanks
Miguel

> M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.


