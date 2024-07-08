Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458C2C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmjJ-00049g-QK; Mon, 08 Jul 2024 07:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmj5-0003u6-E9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:12 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmit-0007rr-P7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720438800; x=1751974800;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=dtjyofXftg4nxcwOT8jOBGTiTpN+VYxFv1Fx8YhzZH8=;
 b=g5YpkfX/UDMjc/4EVtxxzmz//O/XV379ibivWKL2rIOiZeghwoJAxMih
 roUy7mE1B2dEy4R4/L62QUKxJx9DUgI7HhuBBDz/Z5EOq+EUzqPSvWqU5
 sAghVdEteoSrORk2aI2qObYE7HHnF1ksFrS8V0Nt6IWvQlgrl6wQ8gzIw
 iFmBAeuLq7JUJ+Yyt/Ag0fn9dpy9RSIotaaIi6eomQKnOiGIR4l2QRZm6
 /S3Zqfd2NIEc/lwfR5D4vMDmOjsMDTkrSzHUYPzNRAu5Tp+51DUNP0/1H
 cFkmprrRUzzE6ewJenPh9vGDuOUwhVq1YTlGs914Dap0ZEjqOhh4IafaQ w==;
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; d="scan'208";a="16077472"
X-MGA-submission: =?us-ascii?q?MDGjSVips03XgRE8TeMaAxGLgX6MzHCy+0ah0x?=
 =?us-ascii?q?asTFuwGi8vIrPtrVRIhhH8nUzYYONW3FiIPdZ8lrljfDqLdOqrPJJ6JO?=
 =?us-ascii?q?mw0WifE+DyoGgjB6gShCyAAgf5n/9KNXVncfx8Qy9R6P0kSHbmqnIauO?=
 =?us-ascii?q?gP4xwWzKnDMHERV6FQiXs4SA=3D=3D?=
Received: from mail-vi1eur03lp2111.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.111])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 13:39:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsJ/W/ygmWb5+XpJfx3IU+X6cnxtmpD2+mz2q8xRld+cWDxxkk3YzIJWK37aH1sEaZ0fGuH/x9Q6Tl4zClw9OktYoYjw8yC1abRbsHbZy4qyxrcbeSces5zldwLjOhP5mM+urWgetsIvHj7r5UqC72w++y61Qg05R49B/QciSdHqv8Ox7WHaC0dv11UHXMOCJql8fo0bxV+i5xU8GSg+Jr7/RFYyHNSUAyV4pod3A4Ip8zfyXL7IrjFE41Hu8zMkKiPXzG9pVEbgVq990yljrdGa2BtVXs5MB2/EvIcB3JD46/vnTEdjOiG/MKn1eTeSNQ4Hpfg+cwd0K5SST/DpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtjyofXftg4nxcwOT8jOBGTiTpN+VYxFv1Fx8YhzZH8=;
 b=eaTGs+yTze5DfLKlQ8CTrbc+WX0g8D1jmwBBWbfngOyCYGvVK0q2xYGwvgVbSqklwjKpjrTDgPRT8uj5Bo9HRpPaDTpNtP3N7Yecc7j30mcl09L+ot1d/hA5tOD9R+IEuFkoMQXt3s2X2SBehLZ0GALRkh7EyxXDaTaNbkMyqGzjldVGEDpfoWz5s+fVErvRfiIOQK8j0vdAvyrc7dEl/ayjRbeQLyALBZqelQdTYXzAWB5u38wm8isdYgCjSYXu71I15JdhMg09NjE/+VYf/petb1qNnapviv1CF6Yu5WItUUp/gyM2atiw2+w3j8VTU/tLCRvcFsoERjWvUN7D2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtjyofXftg4nxcwOT8jOBGTiTpN+VYxFv1Fx8YhzZH8=;
 b=C8Mo5H6L7gGVOonS4yOCK4qIQxpzXqHV9o0KCkbIg9Ajac5F5d6+RuQik+ngHtzsLMUGy3vQOIE5Hg2hlYWBLY+3C3kKsNnZGEDQbZgejqPtYiOAOtsZVmSJXHS59OfMLk65v2TSRQQNf11B4r9HT3BqvgFHdzOqGbd5FXcanbYaTlaT4XSVzEPZ2m1kJA8x2E6wnS3gecgapGh8TZDLIphGcy0qsv6H4tVo5SxPD+SA9Hvhs4HJQo68W0O66TpZ21SeTRnzLklQPK2OAApxY1tUxiCZANjZhDUdQnszst2EIXFNNvX0HBwNjJIGWsJ82ZSPAzQGRI7Ir3XG+X9czg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7400.eurprd07.prod.outlook.com (2603:10a6:20b:2a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Mon, 8 Jul
 2024 11:39:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Mon, 8 Jul 2024
 11:39:50 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v5 0/4] VT-d minor fixes
Thread-Topic: [PATCH  v5 0/4] VT-d minor fixes
Thread-Index: AQHa0SuLONmJV2Ms6UO3AwMBg0WiSg==
Date: Mon, 8 Jul 2024 11:39:50 +0000
Message-ID: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7400:EE_
x-ms-office365-filtering-correlation-id: 15511c65-9059-42fa-bf0b-08dc9f42ada0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aldEVGh3WXRVVlFUNGJtSnZnSmFRNHNpY3JjNkxPUlhYYmdnU0w4aUxRRWpy?=
 =?utf-8?B?OGs1MkE2UFJwWlJGSDZXYTJTMytPcE16RC9sRlVJSS9talpzTnVCMVQ0TEIr?=
 =?utf-8?B?NG0rVXZPQVVNNWZtUnA5dXdyRm5xK1ZRVVpGWUQ0dEhJWHgrdWFBYUw4Rlox?=
 =?utf-8?B?VWdsMUpiVDh2NmlUL3o0QkcwWTRDeTQwaFFhckpKbHpqM1FDV1F1VWx4K0lU?=
 =?utf-8?B?OGtTNW5yWEY3WHRpbWZTUnk0aFJFcWQ5VG9vTEJYN0RBd1c5M0VYbmFUMWIr?=
 =?utf-8?B?U2Y1VG5FdWZKM1UyQXNkcXVRTVBXdUJHVmdWYnB5S3NMVVVaa3FlazFNZURB?=
 =?utf-8?B?Sk9FMWJ4VER2WGZXdjNJdXQ0SEFrWE9sczAyMDZuV1ZEZDhEdTNIcGdxVDll?=
 =?utf-8?B?SEgza0VuZTJad1FRUXhUNUhxKzJLUnVUNVJtVEtXK2ltYVAvNklDWlVmOTda?=
 =?utf-8?B?UktrRUQrOUZLc0pxM1oxSVdVSWJ4YzVJcmxIZ2F5b0hxN05mMEU4ZjVhMVk2?=
 =?utf-8?B?ZVNDa09rbU9scmxZdk9HbE5JaHRxeU1zajdGNk11eWtjeFR1MFNXbDZBTTF4?=
 =?utf-8?B?cHE0anEzRVBDYkpmWDBaQk5wNnpWUnljQzhHdzZpdUlTSGg0aUgxS2Q3Nmxu?=
 =?utf-8?B?WWVuSitUNEJvalYxVzFNR3hSY1E0S2lFOTJzaDRtWUE5dVViU084NDdDcGls?=
 =?utf-8?B?aDVGd25YV0pJL3hGWjlDRUdZR3NNNEFTTXQzVXdHa1lWbmRUN1ZIK205cmM2?=
 =?utf-8?B?V2xGMUhsYXhxUlVjK3hicUdqRGVJbHM4d0hrSzRUOGFjUTFiMkNqRXlRSVlp?=
 =?utf-8?B?bHBwZ1VBMFNHQjJUM085Wm5FNnBYY0M0ekRZQmhIbHhyeGtBd2ROdEpkYURY?=
 =?utf-8?B?QVNoUGpUc3Vlb1ZGb0plREpEeTFWUUFJKy8ySXlJY1BYMlMzaGdLUlhRajBv?=
 =?utf-8?B?UFErSFBrcDRTcDVwSm02VUpVdmxxd2dUM3dmNm9mUjRLV2ZNNVpzaWFxOEVn?=
 =?utf-8?B?MHFFYmRwb0h0cWVSdGwxbW51ODBTZUlOZ0w2WCtiRmFxczBIQTdwei91eDJZ?=
 =?utf-8?B?Uml1TC9PMkpZdXFWRlpuRXNRTWxjOTBVRnM0MjIvWkMyaU03QndjcnQwMGFU?=
 =?utf-8?B?QlY0UW50MFJkWDU5d25lQ1prMUd6QUZtSU84THRPNThQam9QaVo5YmpBNm1o?=
 =?utf-8?B?YW5uL3gxNy9Nd2ZWNTE0RlBNMFFKWkdrVng5RndXTHE0bURVUlpheWpMK0dY?=
 =?utf-8?B?WFVxVmtOZGxLQTFBV2Q2eTFTL0ZGUUp6bUF5ZW8rVFo0dkxXcHVyZU93Z0NW?=
 =?utf-8?B?VFVFeXlYbTFOSnVoeVdiRzJrc1BRV09kQXV6am5OMHJVbnpiS3J2VnM2MVgv?=
 =?utf-8?B?MXVaYXhjckhkVENTeHRHQXNQSktvbUhjU2VoQW5zbE5RWnFOVEJhcmJNNFFI?=
 =?utf-8?B?TlFNYld4a1ZFSVNZSEpkTlpMd3l0NHczMDdpR3NsaE56WEdsOWo4T2x1TTBl?=
 =?utf-8?B?bG9IZ1JUUGdQNFJ4Y0ozek45dTRpUTZHdytxbGVXOGNWSk4zd0V0RlNKOUxI?=
 =?utf-8?B?K3RHQ3dzVktHRzRsMmNxdGVXZFphTmRvTmk5ODJpZVNFekI0bExQTldkczZD?=
 =?utf-8?B?N1Fua0J4d0tERUFJZVQ0OEc2YlF0dEZXTWl3ZTBwcnZQT3BObEI3dUYyQkpR?=
 =?utf-8?B?T3JWVFk1YTN6bTF2YTRQWFVFRmtwUTMxVjluRUdmOHlXdjFMYmU2QkFwQlg1?=
 =?utf-8?B?WmVVYlh3bWVERU1mUDhqZDI3aDV5QVZ3ZjF1S2Fxa1p0UWtOUzhsMlZsQUR2?=
 =?utf-8?B?a1lEektyK1pXSzZOTFJiUzBEOHlsSGxPTktJSmNSRHdGcWxNU3JBUGRaaHQ0?=
 =?utf-8?B?cE1tdmp5M0pHQ1FpK3oyK1FqS0d6aktxTnZFWSttSnkreVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0tlcE55dVJ6Y09aSmd0bWJxRlhNVkQwZWF2UVVtblhkb1hGV0Y4SWFOTEhF?=
 =?utf-8?B?VjU4NDlndVZkdmJXRVZpaHRaZGN5dWd5MkxYdHpKdWpZUmdYZ1RoVmVvYmll?=
 =?utf-8?B?MHJMUUpoMktVa2xKaFFkZkJaeHc0S0xPUjEzY2xMUFhCaVdCeTJnUXRIZGdp?=
 =?utf-8?B?dy9wMk45V2VzWlYvd1BrMGQvM01zUklBNURSeUxydjJaUm5Ob2JiWktmR0RW?=
 =?utf-8?B?RzhUSnU3NGNpdkNXVng0aW9TY1djMGpjQndsdjQzRmxFa1Fac203N1Yzd3Mv?=
 =?utf-8?B?ZmRYaTBrdXA0eDNkaTJ4d3d1a0tXMS9oclF5VXBSOW5ScHNSeTRnbUF3WnZM?=
 =?utf-8?B?VzRVN2RGcnBmRWdoY2E5TjR6U1UzZjZnb1VNVDErV01rWHl6R2k4bVdvb1k5?=
 =?utf-8?B?RktHejM0S2l6MDUrMmM5YmZseFRNSVYxTlY4Nlp4TktaL0Z5T0ZpNHB5K2J6?=
 =?utf-8?B?Q2RGcERkL3BtMitUdW1QMEJnZ3o4NHh0WStYTEpXdG1Gci9QREVHSzczUElS?=
 =?utf-8?B?bDA3Q0FIWHlmOUM0Sjl3SVJPWUZ3M0lvSURmNW1TV1Q3NFRPTjU0bE1USUND?=
 =?utf-8?B?dE5qVVJVd1FNTXQ1YnBqQkc2dGt5VjFaenZkcHVSWUpOaWVwYkg1b3VLRFpC?=
 =?utf-8?B?SUp4azVFZEQxT0xTZDhqbld3SlFRL01BYWFqSGhZMFgwck1TOUZPNUlWQzBD?=
 =?utf-8?B?b256NnBiWm1YWk56ZXNGTUllc1p3VzZBZnpDeWNZcHltdTYzNzc5Z2pOUXRQ?=
 =?utf-8?B?ZTFRbTNTWXhRS21vWlBldXlpdkZaNkVtcjJWaEw5QVJ1dm9CekorczJVTDdl?=
 =?utf-8?B?bCsxTUQ3bEVjd3ZzdVQ0RERWOERGUExUWGhPKytLalQ3R2ZNSGMwQ2EvMHox?=
 =?utf-8?B?ODZWTEsxYUJraTdjQ0xXZC9PRUQ3bEU2MURRRjdkQVJKQzhZWW5LOTVKZ0ln?=
 =?utf-8?B?RlpwNTNRcW1ZVzBQblpyby9qbTBjcDQwZFRQaE80amx0Y09UalpIaWVqa3hU?=
 =?utf-8?B?L1cvM2lrMTF2cXMzcCt0ZGM1S0NEZEdWWmhUdkFvZ2kvQm96ZSttdHdVREJB?=
 =?utf-8?B?Y2tCNWJyR1BRRWNoczN4bnJFL1VWcjVYUzk1MVROMVNIcXlGcUREdWs2ZC80?=
 =?utf-8?B?azltenpza2h0bEhnWm5LWTIzYmFTTXY4OVBuNWhaMHBXWUdUY25lbnZHTk0y?=
 =?utf-8?B?UUFKYWhNNkRGSVE0WE9aUnNjYnFzODdwZEFWZHVMUG5ETWhjVFFiZUU5VlZy?=
 =?utf-8?B?RGxVeFZsMkJaa01WMFF4bXBXWUVlTndUTm4rUC82aThnNDFhenhzdWdFQXht?=
 =?utf-8?B?QUkrVzFXbmxZVWFoVHZ4Qmw0VGpRZHdvdmFWVS92eE9CU2lLd3ppcWQvME81?=
 =?utf-8?B?VnRzTUk4TEt5M3VLRGhOTzgzVDVBU05vZlpRU3AvcVd5TDB2ZVpWK1J2eUlK?=
 =?utf-8?B?YjdmWWhteGZPZXpycVR6OU9DVDBiNUFkVTJCRGdhQmtyU2lUQ2dPYkxGb2pV?=
 =?utf-8?B?OUVTSFpQRk1FZXFsN2gzU3ZKS1g1bk5hM1RiOFovY3MvTmhPUlBtbXdQSEpX?=
 =?utf-8?B?b0VmcGFnclpRcHg2UGpCS2RZckZ2OG9GSW9LaTY5dlRwaWVNTS9ZeGIzc3ZY?=
 =?utf-8?B?c1hLTjdTQU5mQ2djTXh3WEIrS3o5TEcvY2xIL2gvTUl3SnErNGFSbUY0cEJl?=
 =?utf-8?B?SXU0bEVpRCtFQ0RZTVNIZklSaTBCaUEzV29CRUlDU2lBNlpRQlhDbWZya083?=
 =?utf-8?B?dkU5c2NTYzFFbVJiaUg2UDFCdlRxQkFWd0FDcklNSytwZDRTYkNkK1M4RThw?=
 =?utf-8?B?aEFTVmpZaFNTZTQxNHBCZGx6bk5Gb3c5Ky9sSG53VGg5elhYVFJOODF0S2ti?=
 =?utf-8?B?MHRscUhpblRjTEpDM3BISERHNDBVcHVYWWVNZ2oyeU9RZCtnZUswa2hoN2gr?=
 =?utf-8?B?b1prN2VUR250K2poUnQzN2xNMG9SMlhyTFVBN21CYUJnUmNtbURlN1hSREhZ?=
 =?utf-8?B?amVtVmdObnlkaXpzZkwyUlpXazlYenlGei8rZnBGUEZGV0dNNWd2bmJtck5F?=
 =?utf-8?B?dklUbFZlcVpZTmdJcWp5bWNPVHhNWG9sZnN4YnJjWSs4a0JIRk9vOVcramF3?=
 =?utf-8?B?bS9jUWR2K1hwKzRGaDByMlRYSnhWQkUxNmNPQnJBVmt6d0lEdUZ6dkx4MzZz?=
 =?utf-8?Q?7SAPG8df0cfheQBmrv2vGt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8771A9624E9EE45BFB00110350BF423@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15511c65-9059-42fa-bf0b-08dc9f42ada0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:39:50.9204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kA/a0/39s7MFFDuN0HAeF3UApmviicE0ffS0aU68ao9Yhm8AxLDHtXxtUwcJoBOWBTkzq+t7ZymQHXXSfW7mAjVDUle8ReiK4ubhXxEvEDbIgNaiZMv5vZLKJ/Hh/Beq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7400
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClZhcmlvdXMgZml4ZXMgZm9yIFZULWQNCg0KVGhpcyBzZXJpZXMgY29udGFpbnMg
Zml4ZXMgdGhhdCB3aWxsIGJlIG5lY2Vzc2FyeQ0Kd2hlbiBhZGRpbmcgaW4tZ3Vlc3QgKGZ1bGx5
IGVtdWxhdGVkKSBTVk0gc3VwcG9ydC4NCg0KdjUNCiAgICBpbnRlbF9pb21tdTogZml4IEZSQ0Qg
Y29uc3RydWN0aW9uIG1hY3JvOg0KICAgIAktIFJlbW92ZSBlbXB0eSBsaW5lIGFmdGVyICdGaXhl
cycNCiAgICANCiAgICBpbnRlbF9pb21tdTogZml4IHR5cGUgb2YgdGhlIG1hc2sgZmllbGQgaW4g
VlRESU9UTEJQYWdlSW52SW5mbzoNCiAgICAJLSBFZGl0IGNvbW1pdCBtZXNzYWdlIGFmdGVyIGNv
bW1lbnQgZnJvbSBZaQ0KICAgIA0KICAgIGludGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoOg0K
ICAgIAktIEVkaXQgY29tbWl0IG1lc3NhZ2UgKHMvIm1ha2UgdHlwZXMgbWF0Y2giLyJtYWtlIHR5
cGUgbWF0Y2giLykNCg0KdjQNCiAgICAtIE1vdmUgZGVjbGFyYXRpb25zIG9mIFZURF9GUkNEX1BW
IGFuZCBWVERfRlJDRF9QUA0KICAgIC0gaW50ZWxfaW9tbXU6IG1ha2UgdHlwZXMgbWF0Y2g6DQog
ICAgCS0gZWRpdCBjb21taXQgbWVzc2FnZSB0byBleHBsYWluIHRoYXQgd2UgYXJlIG5vdCBmaXhp
bmcgYSBidWcNCiAgICAtIGludGVsX2lvbW11OiBmaXggdHlwZSBvZiB0aGUgbWFzayBmaWVsZCBp
biBWVERJT1RMQlBhZ2VJbnZJbmZvDQogICAgCS0gZWRpdCBjb21taXQgbWVzc2FnZQ0KDQp2Mw0K
ICAgIEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvIDoNCiAgICAJLSBMb25nZXIgc2hhMSBmb3IgdGhl
ICdGaXhlcycgdGFnDQogICAgCS0gQWRkICcuJyBhdCB0aGUgZW5kIG9mIHRoZSBzZW50ZW5jZQ0K
ICAgIA0KICAgIE1ha2UgdHlwZXMgbWF0Y2ggOg0KICAgIAktIFNwbGl0IGludG8gMiBwYXRjaGVz
IChvbmUgZm9yIHRoZSBmaXggYW5kIG9uZSBmb3IgdHlwZSBtYXRjaGluZykNCiAgICANCiAgICBS
ZW1vdmUgcGF0Y2ggZm9yIHdhaXQgZGVzY3JpcHRvciBoYW5kbGluZyAod2lsbCBiZSBpbiB0aGUg
UFJJIHNlcmllcykNCg0KdjINCiAgICBNYWtlIGNvbW1pdCBhdXRob3IgY29uc2lzdGVudA0KDQoN
Cg0KQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAoNCk6DQogIGludGVsX2lvbW11OiBmaXggRlJDRCBj
b25zdHJ1Y3Rpb24gbWFjcm8NCiAgaW50ZWxfaW9tbXU6IG1vdmUgVlREX0ZSQ0RfUFYgYW5kIFZU
RF9GUkNEX1BQIGRlY2xhcmF0aW9ucw0KICBpbnRlbF9pb21tdTogZml4IHR5cGUgb2YgdGhlIG1h
c2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52SW5mbw0KICBpbnRlbF9pb21tdTogbWFrZSB0eXBl
IG1hdGNoDQoNCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAyICstDQogaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgNiArKystLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjQ1LjINCg==

