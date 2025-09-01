Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB88CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszj3-0002uC-Jl; Mon, 01 Sep 2025 04:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszj2-0002tp-D3; Mon, 01 Sep 2025 04:17:16 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszj0-0006Ln-9w; Mon, 01 Sep 2025 04:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDin9K1MesIatLZhqXEzKVmz+BPB8VvFhI/dk3dXCmcGcRccWYkebTEuAXWsVTI6NKbbjQZYpLRJxWY59PRBxKQlW40Rfm/1Uvsmvp/yE7Hb8C3s9DFs15EEWBxdqjYaYy2XZJCrpBYLll29r04prclLU1PNfhWuhD7tDdjJ4G6U5mCF7GjeE2tSTvs3dnnciQAXR5Ior70LwHMbHXLND0bsD3NPmbFMwuxy2XelHthS0bMzWGSdCcMH9M20BhNd1t5iQaKOOlmRD1bEEHHaLlaVSdqyYhGntJBwSXYid0H1oocj/Brdv5aQTnyjZ1dt3TILM6g2jHMtt2EHdM3/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDcCKUTLpIoslIXFwPbvYbkUnIjBns6rYth6zVd3+kw=;
 b=AMZ6+07O9+wsDk/3TDSYr4nFVqT8bXJrK0GXGNxWB6E4EePsBFCtojinoasP45IMrxSLU9oTtOsJf93wDELFh2GYAvBXjArFch2X8mp/yXcXoJxSYBfvCfBCzBhup1Rn+wBZ7h49cYjTzsrpC53SIdqec38VInlevPZIRoqM2l18q3mGROam5NOlRdecfV63K4qu9S8CdOdk4H6Cjb9pbcrvL1LvxyLlPKpsT/iYfm37FImSdQqAFjlPP+kUu/O+WGSpot1efJVDGaup6fdQayHmy+SaeXWiuDCQCpLqXIafhK+jYMk3wAhFfivxDvpW2eMJBrDUVvEwjNe9504Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDcCKUTLpIoslIXFwPbvYbkUnIjBns6rYth6zVd3+kw=;
 b=ZMOZhIxUOgPny1hWrqTuKCR5FEFsJ/EtawpHY4K+VcKnmocF0Y9GLGIjqhEUUomZG0Z/nfu7basBJ8Qid1JutminLYclNZArlb/LRRRVXVg52IH9q8acGhbnESU1i2yd+PZDoP0eGAmsW2hUdd8d6K1PPhW/ZTeTG8hgvcLI4kCb0Es7tABZgmct3kWunhClyJUo6TMDu+M1zbJUvJV4cgi7W9X1gyVtCVOwFvCXWefgVEXluPjQi6iltnsAsLjQMBX3idJOCSYzE5ICUnC85zpbqH2kIXQOj9gmvfXqZtexP5O6QQfk4Lz5CavwKOrl9bD1gZQanTuccQm6v1fc6Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAVPR09MB6308.eurprd09.prod.outlook.com (2603:10a6:102:30b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 08:17:07 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:17:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Topic: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb9v6UHa5Begn5/ESGcxg9plOYvrRZCs6AgCU40YA=
Date: Mon, 1 Sep 2025 08:17:07 +0000
Message-ID: <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
 <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
In-Reply-To: <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAVPR09MB6308:EE_
x-ms-office365-filtering-correlation-id: a12c16aa-62aa-4b4a-d195-08dde92ff159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a29DMnRuRHphYUdNVENIM2tKdVc4bzF6blI4Kzd0RWlLUHJCTW1CTUFRbjlQ?=
 =?utf-8?B?THRGb2ZqUFlrWmYyUVlieUhYT3MrdlcrcHJpUmxBWHNsSjAybkxQWjRWQ3pn?=
 =?utf-8?B?SjhCYk00YlFyeGdUQllNYWFzeHh1c09HOExpNGhvMUFueUYyV2lDTWd2NnJV?=
 =?utf-8?B?NkdDZGFwVGo1THJ0KytnYjJLU1RHTlFTQUhjUE1HeXhpSWZtMVRVbE45ZStt?=
 =?utf-8?B?TFZyaXFud0d2dm5HS0piQVdFdEZHRzFNTUtHTE1xQktjeXNESmdiYlhmc0lx?=
 =?utf-8?B?WFZ6dXRkYk9ONnJ2TENqQ0phek15OVArU0RrSGF3QlVsSWJ1NG1xTFNkSXlq?=
 =?utf-8?B?T04rQWRERlZnZVN2cDNzMnBLdTNadFVva0FaUWlPS0VndGdZTFNjTUpKdXRQ?=
 =?utf-8?B?aERKaU1scFM3eFNZcXdhamZ3WlFpd3NGcEZIbzlLZUd1eEF6bGdMMXduTFph?=
 =?utf-8?B?TzRHOG8rTjZTZTZYQTZVVVNpUEd3Y0hQeU15ajVQbk9HWG9YclF6bVhLQ0pQ?=
 =?utf-8?B?RmNFYWNGN09LNnFVTWsvYk5LUVhrNnVzTHVpcGNwRFdxay94bC9odDN5RVEr?=
 =?utf-8?B?UHVCcHgwczVCeDRxN3JoMHg1RUdKeDAySlprOTNuRjBKVzRlb0c3ZDRkK3ZR?=
 =?utf-8?B?WDB6NWdPcWV0dS9UdXVoUnFybUFzbVBWcTA2NG9UNHZ1T2lOY09nVnVtNkxB?=
 =?utf-8?B?S3dHV3EzRVlvTXlCLzNlc3U5eUZ0NEQ3bEtJaGg5TWwzaUpTTjhWenFRck1y?=
 =?utf-8?B?akxmNUJEZmFpaTVrVnp1YmlMcWJOWGJtTm5QKzJaMW1JRUNwaUZJcnpmUnRD?=
 =?utf-8?B?anRKNGgrd0ovdWZXWmNnM2xqV1RUVHVxUHc3MDRwSmUyd0IyMjR0OHlPRU1Q?=
 =?utf-8?B?OWZOSjVPT3hCOU5QNituR0dqU1JxZXViRHAvckhaZi91NkxQbDhCV0NhS0th?=
 =?utf-8?B?L0dwQUJTNlFQekJra1BKdm9IQWp6MGllSkhQWUNBTjlIMlJxcjBHVllkYzFq?=
 =?utf-8?B?T3FpTlVpZ2JyS211ZGx3cDhlckNOWnJ6RUFEeE90ZXJaWThkUE13UHhvRmo0?=
 =?utf-8?B?TlNkc1dZRWdGVW5UZEJSdDJsTkZDUlRiN1ZKVTV0V3pHR1JId3RsQWlCS1ZL?=
 =?utf-8?B?dGdza2gyazRQMmFockV1M3kxOHpmWUk4Ny9BeEtQQTJXTlFCSEEweW1XSnpu?=
 =?utf-8?B?QXVtZXk1cXI1TWpySmdESEEwTlV0WUtXT0FPZnIvQXAySkdxM2VOcHduV2d2?=
 =?utf-8?B?b2h5SWQzNkpwMGxnbDVJNnUxRmJTM01LSGx4dlB5TEp4SXF2dVVoZ0JqL05Y?=
 =?utf-8?B?YnE1Mk9zTzVNUjQ0UFRiWmc3aDFlenk4d3ZOZVBUMWtySkFBRitML2REZjVk?=
 =?utf-8?B?Y1Y5cUkrL29La2xYcnJ0SVpRcDF3Y0lEbnRZVzM3ZUpFaS9kWWFHcFRRVVQx?=
 =?utf-8?B?bmU0N2VDL2FOWEx4RUNZaEs5dGtJZjkxWHlXT3p4OER4Z05lWGdNYmdHSVMy?=
 =?utf-8?B?YlFFSldXbVRKZE1LQUlOZXd1ZmZnZGpOUlQ2VFpoaWdpYmZad2JNWC9ySmNk?=
 =?utf-8?B?T2FFOVVndHhQWjErd0ZxS1hQU1JRQjZhUU9EbFhJMCswQnpmNnNiM0o2SHY2?=
 =?utf-8?B?cUdzQU55QXZVYTFKV0hqTU1JbERNVThjSi9KdTdBQWx1b0RiZktEREkrN0F4?=
 =?utf-8?B?c3ZSS0VZVG1SQzNLNU40ZUNIV0orakRDQlhQbFVRUVZnM0NXVDhxSGhpVDRR?=
 =?utf-8?B?YkdrSnY1bW44eVBFT1FZYVNDcE9YS0daZkM0WG11bi9VVWkybU5RaC81Ulpj?=
 =?utf-8?B?TGtGZlBIZWxpNVUrU3c5Wk9GOGFva1BoaEV6VlR2d1JHeGowNHNlNDBXdk1M?=
 =?utf-8?B?aUNHSDFuYk1pTk5XMnJOQUFxY1FYZHNIRm14Z3NMNDJGTXVJMjBjcHBzd3hW?=
 =?utf-8?B?dUlYRmRldkw5dlZ4WUszdTZqQ3BKSVd6MnhBQUFwUGo0VFlUYkxqMk81WkND?=
 =?utf-8?B?a3h2K0V5SHBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU9oT0pwWWFydVkxTjNBL2JsZ1ZFZVR5Rnk1aERqVmRBa1FTSmZOQkR2eWQ3?=
 =?utf-8?B?TU93cE5HMStpWmp5QzFHV09QSnNpa0l2R29xQnc0enB2NXc3Q1BEZjZiOEhK?=
 =?utf-8?B?ME9FZGZ3NXBLWjU1YmpYazlBODVyK3duYUxuZkNocjRBUWFqRmV1TTk5TFBP?=
 =?utf-8?B?bUtqWTh4cFEzMmRxanRVRHFLZk9PUjBsd0lLeTdHUHVQcG5Nc0dOTlJmdzVt?=
 =?utf-8?B?TzhzaFdmUmFJN1RNY2FlWU5XRGNtR0Vnc0lnSnZXK0J6b3dDV0NGekhxZ0dz?=
 =?utf-8?B?MWpLT0NIYjB6bW1Ud211NWNibEFBa3BVcTNUUEsxMWdrYjdoamQyK2tsMXlk?=
 =?utf-8?B?WmFGVXFXZ05jVFVPVnVNUXE1NDJtOUsvSU52dkVXQVdiY2p5MjgrZkJ6c1NB?=
 =?utf-8?B?aFdqOW9aa1lQNzNxWitiYW5uRUcwb3Jhc2EwaGd1ZjBHcmZyQ0t2cjhtQitJ?=
 =?utf-8?B?S3RUbk1qMHZjOWRDRWVsUXhPNTV2YlJPb0lDYjZZWWdDbUdFS1lNOGRVVHBP?=
 =?utf-8?B?bkZlSXdkc3FTdkI4cmdEQ2VLWUc1MjdmODZSUXJrVlZXMVdOOHdsRFNOc3Z3?=
 =?utf-8?B?VnJDNmxiTVNWRktqYndBNk1JRlR4ME1SazQ0SGg5U1E2SmtGTFBMNkJLcm5W?=
 =?utf-8?B?ZytzcmRMUXVXOVM0Q3lLWkZVMEd0UVFxekxzYVArMmovQ0xLN2VHTmxCRFVM?=
 =?utf-8?B?TlpGUXh1WnNIMWttTVYyV1dRSW1vdWRVM0lDV3hieG5rdFRSaGNvN3A3Y08v?=
 =?utf-8?B?Njk4cTZaVm52VnhqcFRpTEhyNTdhNkt6UHRILy8xNldSU3NXVmVhVnVSZmdR?=
 =?utf-8?B?TytuZ05PQy83cVZleWJpZGRpcXhNZWRmWXIzOEJ0Rkh5Sk5mb1ZzZUh1SDlr?=
 =?utf-8?B?elZuSHBWUkNNd3YxZ1BUQTR0K3pHWEdLRkNndkhXcU1ZOFUxQjMzdy91UjY0?=
 =?utf-8?B?N0ZTNytXY09URGpFRWxJMGNIbDFVNHBaY0hNOCtFemdwM1RPV3lobXNqQnZm?=
 =?utf-8?B?VDJFRmp1Q3RmTzVmV2I5TzRtUzRMR1oxeG5CZm9aVDNDeFlQdVVZcnFUT2ZJ?=
 =?utf-8?B?TVRRMHZvQ0ZRT2Rndm5xWkU3R0lyeVNKcFJUc0NVYkJ6bWt0bjBkUHRMRXRS?=
 =?utf-8?B?bDVIOW9WeVplUXYrVVZHbitnYXZaZlFXZThnRnNWUnJDd3BXSVdrNHRId3dT?=
 =?utf-8?B?dDJ1R3k0bUZwekVneUN5Z3NJSVlGUFJqNWlQK3dSb3k0bXR0MzNkSFB2N1hz?=
 =?utf-8?B?bkRMMnZCaldhSTVDTjc1WTFXcmNYeWhsakpiRE5sNG1vU0MzZVFuYzhDMENh?=
 =?utf-8?B?bzl4Y2RrR3VCODZ1WWp1VzNsSDN4WHR0a3VaVWZlVnFaMFZkYkYyb3BvNGo5?=
 =?utf-8?B?U29MVlNtRjlVT3ZVY01YUVdqZERGOVhHNW9IRExDblpJQktKMDRtOVRrbHhF?=
 =?utf-8?B?c0UvUWt2bnpGZktCRGxJQmNTcWpHU3NPRVRrMzEzeHBHWDdvUVVEV3IrVlBa?=
 =?utf-8?B?dUdmV0VqVXFmVmRrWHNLZHltWkVzNU5rd0h1c2ZNZHFPNTdoekVlM0pDRFln?=
 =?utf-8?B?aHhUTU5oeWsxQ1VZRlBqNWJLLzh6Q0dCMXlpNUVlSEdtZEJLVU8yU0VYWGI2?=
 =?utf-8?B?WGEzYk9CMTNOOGQ1Ry9DZzlReE9hYTlHa2hLRFlvYmc5Y2J5d1lPYTZ0bmxy?=
 =?utf-8?B?L2dzOHJvbm1GbkViZkFPTmtkMzR6d0lXLzByN1lTcnVaT3NCeHczTlRxclFN?=
 =?utf-8?B?dXNqQ3BlNjNuNmNoeWp0OHlnWE1DUzYwcTkvOGpmeWE2YnN2NTRCY1IwdSsy?=
 =?utf-8?B?aVZ3MlQySkR3REN3TDVRZVJVYittNTU2NXZYdXFOc3o3bFBnend2Yk1HYWtq?=
 =?utf-8?B?ekVzU05TY25zMEpjbnQxVkUwaVlSOUk3anRPTWNUdU9YQWhFQ3NWU0VLQmZu?=
 =?utf-8?B?Z0h2OFRRbWdJSGVnNmgvZVc2S3VXK0h4ell6aFR1dDdsSmhJOEp5UVpSQmxQ?=
 =?utf-8?B?YXFrVWlVSDQzUERKaFJ2aVhEVzMvcTJQVThSN0RUTVpsYTlJM3g5eU5sdmJZ?=
 =?utf-8?B?WlIrajlvSjNHSElTSHUyUVd6VXdTSEIvVWIreElIV1pvNHFpUnJlTlMydTdD?=
 =?utf-8?B?QzQ1MytNUGkyUld1cm5QYllsQ2U4VHU1V3FVdXlLT1ptRnZWUVl2ZnVQQlFa?=
 =?utf-8?Q?xhCx1gt/d/ZRGpRtR2MDjWA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6143CD699232A24ABB3319F8CDB41B9D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12c16aa-62aa-4b4a-d195-08dde92ff159
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:17:07.7703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93bNnRP6ave3CoRajvmyNUPA5XH4g/AeXo45f81A/y6UA1OyPMAaUpTWcez+iWb0A9Dkj9PbSVDzAnMcWH4sy+iMOwS2P03Oktp5l47oOz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR09MB6308
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

T24gOC4gOC4gMjUuIDE3OjUyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IFRoaXMgaXMgbmVlZGVkIGZvciByaXNjdiBiYXNlZCBDUFVzIGJ5IE1JUFMgc2luY2UgdGhvc2Ug
bWF5IGhhdmUNCj4+IHNwYXJzZSBoYXJ0LUlEIGxheW91dHMuIEFDTElOVCBhbmQgQVBMSUMgc3Rp
bGwgYXNzdW1lIGEgZGVuc2UNCj4+IHJhbmdlLCBhbmQgaWYgYSBoYXJ0IGlzIG1pc3NpbmcsIHRo
aXMgY2F1c2VzIE5VTEwgZGVyZWZzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBG
dSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRq
b3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+IMKgIGh3L2ludGMvcmlz
Y3ZfYWNsaW50LmMgfCAyMSArKysrKysrKysrKysrKysrKysrLS0NCj4+IMKgIGh3L2ludGMvcmlz
Y3ZfYXBsaWMuY8KgIHwgMTEgKysrKysrKystLS0NCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaW50
Yy9yaXNjdl9hY2xpbnQuYyBiL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4+IGluZGV4IGIwMTM5
ZjAzZjUuLjIyYWM0MTMzZDUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pbnRjL3Jpc2N2X2FjbGludC5j
DQo+PiArKysgYi9ody9pbnRjL3Jpc2N2X2FjbGludC5jDQo+PiBAQCAtMjkyLDcgKzI5MiwxMyBA
QCBzdGF0aWMgdm9pZCANCj4+IHJpc2N2X2FjbGludF9tdGltZXJfcmVhbGl6ZShEZXZpY2VTdGF0
ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+PiDCoMKgwqDCoMKgIHMtPnRpbWVjbXAgPSBnX25ldzAo
dWludDY0X3QsIHMtPm51bV9oYXJ0cyk7DQo+PiDCoMKgwqDCoMKgIC8qIENsYWltIHRpbWVyIGlu
dGVycnVwdCBiaXRzICovDQo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBzLT5udW1faGFy
dHM7IGkrKykgew0KPj4gLcKgwqDCoMKgwqDCoMKgIFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUo
Y3B1X2J5X2FyY2hfaWQocy0+aGFydGlkX2Jhc2UgKyBpKSk7DQo+PiArwqDCoMKgwqDCoMKgwqAg
Q1BVU3RhdGUgKmNwdV9ieV9oYXJ0aWQgPSBjcHVfYnlfYXJjaF9pZChzLT5oYXJ0aWRfYmFzZSAr
IGkpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChjcHVfYnlfaGFydGlkID09IE5VTEwpIHsNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAi
YWNsaW50LW10aW1lcjogaW52YWxpZCANCj4+IGhhcnRpZDogJXUiLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmhhcnRpZF9iYXNlICsg
aSk7DQo+DQo+IERldmljZVJlYWxpemUoKSBoYW5kbGVycyBhcmUgcGFydCBvZiBtYWNoaW5lIG1v
ZGVsbGluZywgbm90IGd1ZXN0IHVzZXMuDQo+DQo+IElPVywgdHJpZ2dlcmluZyB0aGlzIGlzIGEg
cHJvZ3JhbW1pbmcgbWlzdGFrZSwgc28gd2Ugc2hvdWxkIGp1c3QNCj4gYWJvcnQoKSBoZXJlLg0K
DQpXZWxsLCBpZiB3ZSBkbyBpdCB0aGF0IHdheSwgb3VyIEJvc3RvbiBib2FyZCB0YXJnZXQgZm9y
IFA4NzAwIGNhbm5vdCBydW4uDQo=

