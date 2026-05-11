Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282E0CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTfA-0002ZC-UP; Mon, 11 May 2026 12:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wMTf8-0002Yd-NK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:39:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wMTf5-0007St-Fc
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:39:22 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BFtbCp2859222; Mon, 11 May 2026 16:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pQBwx/Idp6SKvE0VRILzQcJysYbxZHOtCM12BvLxkoU=; b=
 mhB/ByIIJ0vMraTbN1mhc8XI06QvZkoZ8pG/Tn7jCVy1sTbn6iws0/HGpTNJ1USD
 Ro3hf8Lcd2NVSuTKLcbu7kuiqi4xekFWEjQEHsDapZuflNMmqDmMXYR5dNbfeHhI
 AwkymvbzfQWHqbREy7EpCrBAP/H8W1lgjej3fV5OCbtz2VNC13sQ9yYKdSs6agX4
 jNhoFRqidpwyUyKFXW/O8mQrd/OPEiJ2Uhi1WdIsMQQMGRPskYkA5bv+NCnJCYD1
 7pgTbcaM76ADqKDk3uRMJHxeeFBygtNxStw2wJ+OAqkw7O6xW97yjiQ2mRw5qrof
 E40KVpg35GFSPyCmgMVFfA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1uu9b2yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 16:39:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64BGaKiI034021; Mon, 11 May 2026 16:39:16 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4e1uc9fdmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 16:39:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz+iX8VuZo+PhfmEUAES+G7y3B0A0MS7RZEnpml8a525/3BOIq/XLU9LxPnthJNLbS75Wy3YZW39wDlH+TtCKsEQUH9iFXu8m4c2NvC7/1KG/8qo+Bkw+TxTChBB5x85HXB3GwPxUZ9R7SJylPjqblJseIX7rqB9ynCA93DAcnim6fcRRVSZ8KhXBRDm5RmX09echbyI9I7czYSjyiB3ZlMez6Ru0E0IeMCnJAvMXAYk37CEBWiNIm7iT+2wI0YUfnSjMcM0TbC1dm7ghO2yVLpB9SZ5s2qCm4bTR6NidQtKmoGR32vGb9WJQ4Nn0eVLDlrk+3MU7sMYpvOrkSxgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQBwx/Idp6SKvE0VRILzQcJysYbxZHOtCM12BvLxkoU=;
 b=xb27nsra0LXlAb6bENLw+mQeN+JGkEHGpZxtw970SeX2cEw8+GcH1RnSVp7wdONhdWU0Ag93atGbkbMpRCiBDluxUOio7qzgiPhVJOa0CtH+ZU8rwULrEKgtsY61Ci3Aqa7SnI4buQhyGFb4P+SpfUDp4dvDFrFmAhacI3U8NCLgI8PiFkD1GiQJIJ/rqSLqs0fK7gIj/aPNOndCkp1zaBTJCIGFsTO7Gdeb4U4afeEubptRzzYRmsF+9df2Q3VaINdZZ7iR1+78/mNvdFrmFh+DTwWzSq7vWB9jh1hKYKq/HmVKFwyTIWmvGynfOWNibcd5x5gz9A1wQOXFwNBDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQBwx/Idp6SKvE0VRILzQcJysYbxZHOtCM12BvLxkoU=;
 b=a8edrZTCZpur+MK7LuSvxqf3oPO3zcpGa0lDlXI0YwPbNFDO9zkR+DPyQ3Wku6LFR4paL7mVTs2KAMacfF8TLlG3ew27yYr+ybR+sAavQ8UuNH9tUBUYaegJe7qKSpngdop7sCHR5gzdHBIbCSO3HrF/sml3+7g+eIAj2TQNA/w=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by SA0PR10MB6427.namprd10.prod.outlook.com (2603:10b6:806:2c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:39:10 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 16:39:10 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, "clg@redhat.com" <clg@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Topic: [PATCH] Mark Multi-Process QEMU as Orphaned
Thread-Index: AQHc3tVAODNr3sAyP0CIkVhxZI9/m7YELdWmgAACZwCAAAE6WIAAAVgA///FPgCAAEZ0AIAExSIAgAAEYACAAAJMgA==
Date: Mon, 11 May 2026 16:39:10 +0000
Message-ID: <E1A7DF59-DC48-4F3A-9913-0EAB0ED586FF@oracle.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent> <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
 <af3_CqQf1wSSWYYY@lent> <88BAE7FA-7DAB-4372-8710-C45E98178EBA@oracle.com>
 <agIDElJbbToE4jWj@lent>
In-Reply-To: <agIDElJbbToE4jWj@lent>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|SA0PR10MB6427:EE_
x-ms-office365-filtering-correlation-id: db922975-b842-4b43-c6d0-08deaf7bd3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|3023799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: V24mJe+YUZL+nyXkusuEGf/eJv9ruqkaoTMWSW+YeAgwv/ksNzEq6UIXQVRo9f2gk0Ts/l5s3Ftup49Ywtfv1yN2x6/rN4brR0ig9IgZOlAJoBH7hiH+bdGMRZQ46E1fDvACOVJwqfypGaX7NB4tuYETShOaZYMiC3WRs1z/U0kgnjOjEGvgxInK8rm03dnyupI3uuCO/3fnjCX8HPTwlihsIZoAtZMb8Lhaed/1TVofvwa4wqZlttVYdPmRXlQJJew4SF+/9Oo/MEBfcdpa3wFezoBMDLJXRFxFHANaPWrKqtME4mnuZbi9mROm6erQFSqNSEE5XVEELxD6VU1C4FhqJX5N0krNMxWdERNQUMDE5Di6bn6HlnUhCJ1HQhqEo96f3/jiI2w66gW9WWnHXNs27t354JrZsPrmaKlF+Fx6upfXo8ysekihaDGFVXFFzagntKns+8MH54v2wOahR4gI5wlT2+nqBN37eozr5Te0F1bs8Faz2HTDqjePveLv/lK36DNLvYU+rItACmAkc6LzAOVkXJxK2nxfocK1BH3O3fVDnxju7IigsLBQmQuFpqb1Oe0gUtKl4O61axqAe0t1JkXa97RG3d1euIzkpImYuB/21cFQbYKE6ray56+fneZbRzmd+qmCToFPuZl/34nfkgMjZ79Sf6Gy6Oxh5Fl1SZmLx8hWoGuVIC7sPtefBwch0QMBoqt8cufgUdwjy/TwY0I5VGsglYMiGDpakW1TGNap8o0a1mvGTet1V1re
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Slpmb3daY3liMGozeUY0Unl2d1ZoM0Q3VG5jdVhsejAwTXhvZUkrVEF3UkVE?=
 =?utf-8?B?cnRlakU3SEdzaytnaGZNdm00YzJYdStFZG91NEFUeGc0dG03UTZhbTdwNGVs?=
 =?utf-8?B?K3JvODVUc3h2ZElHMXVFcEZMZ3pESkRQbHRTaFBBbkhKTnJkK3J0bVpBTkhm?=
 =?utf-8?B?RW1ldjRSTWpVeXBsRlZJM3Q2WjVjUER4WGpEbUJEalVDREtSSzJXR2IyNWVT?=
 =?utf-8?B?Z3A1ZG1xbks4NXZENmdOOTliN01NU0pqT0tFeEx4bURvZkVkTVdOOTJoOHZx?=
 =?utf-8?B?bVNzUm5pTTBNMmRBT2xzQnNEQXVWbkxJTUZLMms1R2dCSkdxV0pXbXptUjV4?=
 =?utf-8?B?RElUTkxxQkxWZU01UEpEN2ZrOWVpTjRZNjVuSFlDdWFjVTV6UWI4Smg1Q3Ro?=
 =?utf-8?B?VEkvQVFaQThOSTVNbFVaL09VaklFR1gwY3JWb3kyRXl5UDZvTE0vckptTytL?=
 =?utf-8?B?OS9pb3dKY2RoWGFBRWZCaFI1TXlnWklBT3BsUXVYMVVDOGFGT2I0YTErVDZV?=
 =?utf-8?B?V2l6NlZRQnZzME9tcFhFOWRkc0FJTHIxMGJHM0U2MDlwVXBmSnRZR1o4VWwr?=
 =?utf-8?B?NDM3eTZwYnd2Q05FeHVMM2ttM2dibVI0ZjNJWnVQck1YV1BlNHQyMVl5bUs0?=
 =?utf-8?B?UXFkU0ZNajNUQTJpY2IxTkhBTGdWRFFYUnFHbzltZWlibllUYW9LSkp5VzlX?=
 =?utf-8?B?QTJtcExKZmpHU3FHL0FsekxZdnNzQzlKNEsvUDR6Z2hka3RNRG1Sbkx5UHBR?=
 =?utf-8?B?V1YxTnlyY1B3QWhQR2REc01LdFJxT1FiUjZTSllJMWhmdGxadzdNNDl5RHZz?=
 =?utf-8?B?SEFzZGFES2tuUzBjdUZPdDNFLy9UZy9LNURtNm1NcFB5OUVUNjBSYkRxdUJp?=
 =?utf-8?B?YjhndGpxUmFjeXBhczFIek1RTVBCRE92QnlGb2R3bmxoSHlERXJhNmtibnRr?=
 =?utf-8?B?SjdBektMWVFKVFhyN3hwVXo4V2hVTUVtT3FlSVJaWDE0cUVTL3JERDdwMXgz?=
 =?utf-8?B?VUdvc0NZR2lsYzM4K1VqWk5iTGo5eWZOeDJKemdYSjZFTzBDVkEvbW55dEtn?=
 =?utf-8?B?N3JnY0RvdlgwajhtNTY1dmRkNzRrSldCbG1RMCtEUG1hSndWSStWd3NTdVJz?=
 =?utf-8?B?aytSenUxVXlwbnd6dFE3SDI0MU5vZC9ubnh3UWloTkk5bldPODM2bG5sUmFp?=
 =?utf-8?B?bG5tZVplWllzcXlTS1NrTjNOS2pxMnc2ZDA4eFEwdVU1VUwreU90VUVVcVdX?=
 =?utf-8?B?b1FlSVJWbmdYb2M1UlRSVStpUFVSaDN6Zzh2UUxCSEx6NEUzKzkzakNNVytS?=
 =?utf-8?B?allZd1kxcno2Z01ISnRZbmdRenhjOUhWOGxEaHljanI3RzRBU1VNWTFqbzlR?=
 =?utf-8?B?VmFpMkpENndxMjc5NCtUM0I5MUs1TnVPVGQ5ZkUxN1ZDOE5qUU1Qck5PVXcx?=
 =?utf-8?B?amVZcEJXV0lidHpqOW1DVXp6MDM1VkZYUmY1d1ZlTktYVWp2M2J1QTJEMTlz?=
 =?utf-8?B?R1g1djErdEZsMU1rZUtuQVdUU1NTTlBIVHVxWjBwSk03YzdYMVplU2ZyUEhs?=
 =?utf-8?B?RXkxNmRZQk40MWdOWndxR3VobCszSnAvT0orc3hReldBYnNFTlJkNzExdVV0?=
 =?utf-8?B?czB4SGV1M2FtUEhKZ1UwcTBGOEJ3TTdTM0ZxWXZxdWV4YTdvZ3hOTlUySHBq?=
 =?utf-8?B?NS9ucHg0K2tvQUhrM2xLeGxqTTFXZWNkL1pOZDhsd05aMitRL3ljVms5R3ZU?=
 =?utf-8?B?aGRJbWxTU0hzZGxldkFTYW9DKzN2WWpQbkxJY3RlbzcvTnVUSk9CNGVZMnRU?=
 =?utf-8?B?by80OHFlaEFjRUttc1luWkdGSG9Kd3ZGK0tRYU96WjIxTXB3OEdhUjg4bnJm?=
 =?utf-8?B?L2RCWlVYckhNbVZ5Qlcwa0Q3bU1QaTlVNFdKcE9kMkFkdnhzQ1FhSTdoVmo0?=
 =?utf-8?B?RkJJU0M0RWxtL3ZJbnA0TU5qVk5NOEljMm1UamR0RTF5TThERDNpcEdpbjlJ?=
 =?utf-8?B?cWMxVDNPVVZCY2c4OXd6M2lMMEtkYkxVMXZLKzdNNTk2cy9xRjFudUViZW81?=
 =?utf-8?B?bmRGSE5iQ3ZtblFMOGpwbnZqYUN1TTI1YnJyeWE3S0pjcGxSUHpXblg3VHlC?=
 =?utf-8?B?NUNSQzloL0pPMURPZjljVWtMNUVwc0k1aFBBRTR0ZUExZTA1VzdWd0JBNm9i?=
 =?utf-8?B?YXZFRUk0ZnRXMmJwbzBKR0Vxc292OHhqZ1l3OXFmcXZ1eFNwRXp4TUh2dyth?=
 =?utf-8?B?TERPM3FJMjI3eXovNmNielV2eGM5bnEzb0lqOWdPK0s4QW5XV2ZGa2VDbUtz?=
 =?utf-8?B?ZDdXcVNzdkRvWTFqcmtvNHNEa2dlemM3OU9Hek45VExaUzdYaXVPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9283EAFCE76AFC4FB341C8464BA25155@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: in9PxqWvpl94BwuG0jhlI/yqcFlD2GoyAkaR57nM7Crn6lRHuh1rMf84gbfh7Xcr47iCIqeGBZAHC1qfvGavx5n6JPIeiOK0g6bB/CfXdKNpP5VD1prn3p4YnhNZ2P9PeLDlpJ/KaCbp3VgXGM3awBuK/Bco0BjWbVQU3zAwOJfB3RlGt/JpfIC3kXv+6PMDqr95XwN3art6e+1O4e+gtIpMmyHkN1smN0+urr+Hb9gMeCUKCrEteIxJkZ1rKGS1viBzQw0/vKS+njrgh6JtBLM+N8ISzADTEow5bwzRzxgR5gR/XhEH8cg2A6JL6Hv17/WMw7lyttm0hwhsKMmqEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kqJUQhNZp5ZlUnq21WJZtbZzMZWKF2BIId18LlReDYskzytk0SSRD4z9IE/mJDKhMIVxGhggzdm7AKMIoWF7HRA/K0rou9zIyM2q52WnjzFS3OTucYJzFUfBbEzz16MbbtiIYrtsviJ7Wkf18ZpiUiqmnajtaldas6+/x/pXzC6Khw2rt0qxSoXYwPJKT/jq6ZlB3SRyys6cmXx5Y2bL6PeTVNdu07ZUqauBSqH/+xfPZurwv8gAlUgbptN3WGz91/ObdJf+/zrjnKjE4373WdVLdA7zZK9rFZUE2zNQ+RejQuSvKMn11H06ca2oY4O4TVzpdlyJg4OEOmxkPNOuWcOd8s9+J1MSem0301n1SQDNbOS8pRu3yt9XIEAzVMhl816caYdfb+tGyljas6oG45nM7Rp2xIqpNDj9CnrIdOV7HpwU0qG9cGlB6SskJ1lFCS1T1SyTAN/QDVokPgl7/oXeH7jfO9Cp1bqLWvqNkmerpKWJR7SBoCMDq8gEz3dgwLzzvDAKcc7aJyDEIuhEdn2+kpqgb7p1gyJ0IWtYc3SIi/AS+Qzxjn0JnhheYotmbS4wIOX3pHQjRTQBFQGsNcKCQ5ldmC9BLdLRuhNe6UI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db922975-b842-4b43-c6d0-08deaf7bd3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 16:39:10.0831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkduHz8PgCvmkEFu4/hkPlJ66mFP3uTo1g1UQ33rIes1QwIrRpbadhQhvL47/rnnz42sgSggW+Ln2T/CrGX3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=903
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604200000
 definitions=main-2605110178
X-Proofpoint-ORIG-GUID: xO1wCJ84VP6SZlcF3tQch8RDI1PFusEb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NyBTYWx0ZWRfX3cdaGx3B7bjO
 l9rEtrnwVgQ2VngdDY7/vJYIKmLgxvUeQkc9y2/KuxfoKFxhnKaGnbYOuB/YU8HzrsWLZ2ilMGV
 6j61l1uIZ7TjbDmwyNjKVFZxY6bnVG7pg19HWEe7+D12k5RXdyUl59Wv6B9f1y5vDdWkkn0TpOc
 u6EPhtVNum/OavJkKZseqc0LrKD4skWVLYkFPCrCyQApfnKLRL8/uQiKgRVz8KOBuvKWL3OP/y0
 yhOM0RXB5iJSZ74wM75xZtn/ss1o80zAhtx9vEYD4LLcffbZxuB1K/YxzZ171YLPm2PPPYFRthk
 oKYjO2rR1nJQAbXM37xSWBquwqc5qV59JzAXDyu48xEoV/+vGsZhKj4hdIjwNMB1/oTgGmP4Dyp
 PN7my+B73MAPuVsDjUZkGjXKDakLk6TQ/VZ1TAYRxCc30BrkipSuBEUZhKdtUzTelJ2HTBbqEhg
 2jHS0XfQVhhLaMMyPeg==
X-Authority-Analysis: v=2.4 cv=SuGgLvO0 c=1 sm=1 tr=0 ts=6a020635 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=64Cc0HZtAAAA:8 a=NMd40lS-NQeyZwIIrWwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xO1wCJ84VP6SZlcF3tQch8RDI1PFusEb
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gTWF5IDExLCAyMDI2LCBhdCAxMjoyNeKAr1BNLCBKb2huIExldm9uIDxqb2huLmxl
dm9uQG51dGFuaXguY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWF5IDExLCAyMDI2IGF0IDA0
OjE1OjE0UE0gKzAwMDAsIEphZyBSYW1hbiB3cm90ZToNCj4gDQo+Pj4gQ29uZnVzZWQgYnkgdGhp
cyBjb21tZW50LCBhcyB3ZSd2ZSBkaXNjdXNzZWQgYmVmb3JlIHNldmVyYWwgdGltZXMgdGhhdCB5
b3Ugd2VyZQ0KPj4+IGdvaW5nIHRvIG1pZ3JhdGUgdGhlIHRlc3RpbmcgYWNyb3NzIHRvIHZmaW8t
dXNlciBpbnN0ZWFkIG9mIHRoZSBsZWdhY3kgcHJvdG9jb2wsDQo+Pj4gdGhlbiByZW1vdmUgdGhl
IGxlZ2FjeSBwcm90b2NvbCBhbHRvZ2V0aGVyLg0KPj4gDQo+PiBKb2huLCBqdXN0IHRvIGRvdWJs
ZS1jaGVjaywgd2Ugd2FudCB0aGUgZnVuY3Rpb25hbCB0ZXN0IHRvIHVzZSB0aGUgdmZpby11c2Vy
IGNsaWVudA0KPj4gYW5kIHVzZSB0aGUgeC1yZW1vdGUgb2JqZWN0IGFzIHRoZSByZW1vdGUgc2Vy
dmVyLCBpcyB0aGF0IGNvcnJlY3Q/DQo+IA0KPiAtbWFjaGluZSB4LXJlbW90ZSx2ZmlvLXVzZXI9
b24NCj4gDQo+IEkgdGhpbmssIHdoaWNoIGlzIHdoYXQgdXNlcyB2ZmlvLXVzZXIgYmV0d2VlbiB0
aGUgdHdvIHFlbXUgaW5zdGVhZCBvZiB0aGUNCj4gTVBRRU1VXyogbWVzc2FnZXMgZXRjLCByaWdo
dD8NCj4gDQo+IFRoZW4gd2UgY2FuIGF0IHNvbWUgcG9pbnQgbG9vayBhdCByZXRpcmluZyB0aGUg
bm9uLXZmaW8tdXNlciBpbXBsZW1lbnRhdGlvbi4NCg0KTWFrZXMgc2Vuc2UsIHRoYW5rIHlvdSEN
Cg0KPiANCj4gdGhhbmtzDQo+IGpvaG4NCg0KDQo=

