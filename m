Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509A3EFB805
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul61-0001al-O0; Tue, 24 Feb 2026 00:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul5v-0001aN-AE; Tue, 24 Feb 2026 00:36:27 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul5q-0001H5-Hb; Tue, 24 Feb 2026 00:36:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPGTo/6oH/76QVnvTU9HBZ9uXDwVZhfgqJPtukOMnXbORMYaMtSp5Xn115EjbTOqXuajYySL9ZdTuX+gAO838VdhtQLzastmKEkeHxNhP8L37ZRSQVXkEs/IvhmOdueLypmzYIvn0FoYuBeDURqklXwtsbTF5p+yOD61w6Aq+JC/QQxKHMnzQpd2mN4iab0cgAKR6C+2y/BtfC5zmBccia9oH2tWnEDzyF9fh8U17GlZnIrAUu5oV/oZSbyZJpqrJGaSjuaiA3P8gFM2WCnvjHjkp4aXVUOymgAkJQgmvo0ipmS5SGwUA1RjfSLGy7Jxnennsf5kaxJvZxMQnNtcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfAKAhw+n0wZw8NrrY7Jpngd+Y4PzINBkAFBkLO8wrA=;
 b=C14KfL93QzFtpML0mSNIKozWB1+3yaP/7IwLQsTumo2LiV3nO6nuTBlT/Uz8vqk9CGU6sxhtKnMw0spaK/z4SdCEeBU3tgWDLpqqjiG16ZsE4ueH7ZngouVFdOl8wCDGWPhvhbynpNtuMrhHRFzBu0amMkhP+cz3EJ36ZHjeTKNG0P7z/HB86s0AS3Swz2S4ZG1OGQl0BfqCqWD898IxsRTDSCIfLkKf2pzRz51HVmouquQjo4gRGYmDaNXI/0CNDPyxf2WKooRNKSnZMaVg07zGdcxIGwh503sMv4Il3JSfx35wYa1hi4Tc8q0dpp0XdBFMol9NQLSk9ohrQ+WW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfAKAhw+n0wZw8NrrY7Jpngd+Y4PzINBkAFBkLO8wrA=;
 b=ikUTu0YpyE8yDXnE6b1c9hPhTwp7k/1ndQ3KSIa5mHvCW61L2S2h8KS8+EHcS66HW8Thn3/D/R1DuoQAee/MSko734C1Z1igNAtuDITSuY5O6gBphQtllYoSjtwOfeu5vD3EHv5IOkkJJB1aWL1ISdEzwLbY9TDsT/OAs2C74egxyzWtY1/fFkmiISP79093tmois0AC/D//RyFO0jLw+woCDLrnQ5BFdbTaf5xei0CdNggwxubx2u8M8SbLYdGcht6rhhtwKbKtMjLHfiU+GI+R0jDNFPRFr7+w7qO7m7FVb2dXOJgzBkW/Nuvcm+8GT/uBKtNI6GKkbqjdHqNE8A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:14 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 00/22] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v6 00/22] i3c: aspeed: Add I3C support
Thread-Index: AQHcpU99rJq3hmbu5E687Q7yZjMKYA==
Date: Tue, 24 Feb 2026 05:36:14 +0000
Message-ID: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: 1bcbe1e5-1f3d-4043-c5d3-08de7366a05b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+oTc/3RscMLPLi76wObbuaqu2hhYNPFZIvwOZswpaGUd6JZs+AOeVQKN4H?=
 =?iso-8859-1?Q?IY82mmKzile/50Jzt2EhQ2mmwIeb1xQmamDJnCcR+GoqMOiqVgcdIvbDW/?=
 =?iso-8859-1?Q?MAP/Dmq9xuDE6JZRNEUfygxgofzfWEufBRJx1o1rdwuCTw+Hns4hgzzFYb?=
 =?iso-8859-1?Q?zOKtFi//YXymEHawkyz9/hLT6LTgIZDrC5HLKlTGRRQmeRH7LaKUn0QIsN?=
 =?iso-8859-1?Q?1UKI1B0NuY59LwRT/jqLTtxN5cRR8s60PMKq7isGR1TLHWyOwIEgdSLDj9?=
 =?iso-8859-1?Q?rNnzYKY6UH/WhAZVFrT5u8pUSVUuPSBoCLyh+5yLxJdzdYaT+ltIpH2jN7?=
 =?iso-8859-1?Q?5A5CyFzBIA6q6TV/RobztSS4Z14AChIyQBM5L1LhKu1FRv/BSG4N2zWkyg?=
 =?iso-8859-1?Q?dRtzaXqQj/iR2vGcKzaFx1lvTJAXaD6bs01rHZoUA8a2oh5su2iLGDnVYs?=
 =?iso-8859-1?Q?nlEt0BeXWFJkKmHYRrlVA+6wZKEnKccJm7OCMDAx06Ym0g/+COjycFEJ0U?=
 =?iso-8859-1?Q?vArjtUyNHv0a8+azHh6tw1TPSUI+kWD+htEbE+K3tK08oqPOArrX0joTFl?=
 =?iso-8859-1?Q?Uvzv/jH036NceBtRVTZMltP9dYSbIvQb35Lp3Fcb6QtLTGMipaQd9X1WOj?=
 =?iso-8859-1?Q?dvm1riTopOK+qJOQsUqk2XOqfwjxRRIIGaKFPY/C0BV8rOULhBmVbF8tYT?=
 =?iso-8859-1?Q?3OcrUULaEkUZbdjKDIg+C+mgpcecayPy3A86p+TnMfBw/i6B7aXSKeI9+6?=
 =?iso-8859-1?Q?tWSWVygn+LkRxx+NGZ0BMlVfkp7wEwXPXWCBSxrWg4zTNRQaFIf27JTaRz?=
 =?iso-8859-1?Q?Ya6MD78R3JiY4E6IG2UVbBghCMF+rthR08ZOHLme/3kDy4TbRuF0MdZ8+z?=
 =?iso-8859-1?Q?BZa4cKOIYY13Bfmn+0JTSAYVgczWpPQF3DvDLXrBKpjyvH4HeEs9PTPbNZ?=
 =?iso-8859-1?Q?TXumUgf5ePqQ2EjikzvApJ1Kw3/94u3Qcj5OchwsIXzaxpgSEHXzlgZIdI?=
 =?iso-8859-1?Q?+4oLRk0oVOIqboJ/WEICwDVN1IffFOatXvQ9yYJ/Hp7fg7YB3un5Fmhwdf?=
 =?iso-8859-1?Q?6IZNZb2ZiWKq8SWbeVTNf8oHTLkq41j+5h2P6WauOMZu9NYWQHKW8/rmBS?=
 =?iso-8859-1?Q?0w8RYqnAzIChx6E85lYfuvgyY44J1WdioElI0Fqz2gSW6FW9hUKnWe+Usl?=
 =?iso-8859-1?Q?KzCVPS27ukeo7UXTTVdxTT/SXAKMHaJKplIn5ihr0S8Bxjkh1hg5pf0M+B?=
 =?iso-8859-1?Q?dMGFGrxqYaAwmosCpjXj5U5K6Rdswl5pBBArlijWntBUZEvbBx/FVwT/k1?=
 =?iso-8859-1?Q?NVqxpIdYfUJzQ9H1OXtQ3jRun5C2mXWPRmNwPLkpr+AElWUtQTJDDcZrhd?=
 =?iso-8859-1?Q?oAqv9ar459Fsyu7oO827AuDszQgEeDbQp3kILpBOWMuIkgszFF8Dkur3td?=
 =?iso-8859-1?Q?fLdCAXBe5gpLzYU7KpFbqchioHAcm2jNYNX0mvicIxkg11ywg2iYbWg4kw?=
 =?iso-8859-1?Q?XtXWZ/9BIPsxyb/2b4sLHnPGKgb3ixIxcsKwr82ul10QQRE+aexWSO2FFg?=
 =?iso-8859-1?Q?jyOb5HPiIq5oncSFp2kU6HxBaXXN8Imv12ZOLj+AYFXZwwusJiQxVe3E3i?=
 =?iso-8859-1?Q?qDZZYp+oQKwT6QOX2etKwaOB5Y3m/4Pj8BLMsfBLMR7YKuL5SlLOqZRbSg?=
 =?iso-8859-1?Q?dYsu3/NfFSRJ8TWw86aYb3Ei+LNixZuTubrJu8uH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j492e+h4KhzphzYDEYWoqQJgMdfz1LRYxjztbQXrWe/SbNikBe1YwPvIuH?=
 =?iso-8859-1?Q?yu7TXobw8bCVuFqXD0hSsyV9n8OEKP4eSWbJO2Mo8IqwzATRRxdY4P/pdY?=
 =?iso-8859-1?Q?4a7HI6doxcfrD+r49vue1/4wDQLI0tWp1jndLF48z6R/YXfyDqL6jZOd9r?=
 =?iso-8859-1?Q?UahwR2AvSM0z7CvSdnVnFQHV7vrIn84xJz3yeH9cXlK0zHgUHNh41aqZpN?=
 =?iso-8859-1?Q?bAJsBvrcS3SrUpa42T2ksrABiguNSKhGQJyO33ABWc1rBkB5ujMixPJkTd?=
 =?iso-8859-1?Q?0iyqxvhwk4StncaTyY1vk63PQNKFPuA9Dz8AC96/V2kBrDP8nhIxUg7t/e?=
 =?iso-8859-1?Q?bRwSKxx7MZb9j7eQVBbKXbKWqANX08gX5LHDLr0LOF/0f1ch6jVWsmQmns?=
 =?iso-8859-1?Q?MSx6Vdc5d38HygBY87ubxcNn4cTCSF3BrMYFb/W1Kx4Hw3j2vYT+uzOtoH?=
 =?iso-8859-1?Q?JdtXqI28k7i3dSSWUZmFIkV3EEDX3Rkr8X/iyWs7w8CIBCNED1RJD7e/18?=
 =?iso-8859-1?Q?3kIu2K7GSvnayVaM/GvVGO72B1Kab67b42HbLHvOV9HHZEheMcP51781/i?=
 =?iso-8859-1?Q?oi85xtEFV6jpzGGElp9jw35Xh+0ydnuBYnXaqCqAnaJXC3H9cVnZEU6IQw?=
 =?iso-8859-1?Q?TJrHmdM6EVss4yHl/TBUJQpUaxji9ipQxzMak0vDGYQv2jmjtSTNfziQ2J?=
 =?iso-8859-1?Q?I5Oc3b+ksoIltVnTSeBC1EsFfPzAokFFkXBnA9W++cvBW+QWtRcgoH9jvE?=
 =?iso-8859-1?Q?fttWRQbIUGRAs8ORNuwIrn9cwz3opgCnzgjjZe/jBX3KvJS1EKemxqTMJu?=
 =?iso-8859-1?Q?vUJtuV2CEJEOnTh5CpgoVuh0fhIplOhb/ZifOlRBajP/clQ3/ijrwr03QT?=
 =?iso-8859-1?Q?UY5rGKab8alDvjUrt5tgHcMLJp88Uw1O1XSopsh9/AMvfiQ+F+SUhQjFl8?=
 =?iso-8859-1?Q?KyYR6WD4cNpT5dPqCzoZQ91o/+Uplk1lXiepry4aDLzO2AJOaYNM9V5S+P?=
 =?iso-8859-1?Q?Xa2D5xAGH7ij6VZbyxvM+VTIHpfl8f6BYvPwd43dV2vDvsKmdq793Zpt7B?=
 =?iso-8859-1?Q?5K9+nYcNCrtWVlcMIsPSO6mady1Ty+m+HOpmhVEiVFi8r7aSk2iokXHeKZ?=
 =?iso-8859-1?Q?pRm99BBHzYjhRnQJj4tU7Dg5mdSBHq0x6OfqvtOmDR3yH+Q9YmCBAR+Is2?=
 =?iso-8859-1?Q?VIBEJ5CWzjVdG9Xp5p4Ux2/zyF/FN+g0TevTb3qBarz8QWhAEZQ2t9Gk0E?=
 =?iso-8859-1?Q?lEFQv4W+bNUAMPPHoZ8ttH+i4YuO4WnJ9qwXLU/gLtFxMTUcTuQ0QYMAag?=
 =?iso-8859-1?Q?d0MmFoXLiR671x82hFMexMnEsKECGM1Ip26GcLKREG/SV6XlwobpxTuKqW?=
 =?iso-8859-1?Q?1wqopeVQNguXYu/BNeasM9sZlCKCBRqVITBAeMVs4DrEocgbxXbgKcVnyE?=
 =?iso-8859-1?Q?caIRhEbmpPmnCp4V+fXMSX63QdInX/Bk/JzSVccNGPlYPBD40vG//07e6I?=
 =?iso-8859-1?Q?2DBEkUF/XaPJDKRqDaJA5MHnvHMM8O8dN7fhkxFUAn16vl1lGSM8eYSKAA?=
 =?iso-8859-1?Q?evmASVgop3yRylySthET/+bHkTTBqRsOnZnRTUEL7LuBgoednDjwoYrs8J?=
 =?iso-8859-1?Q?tZUJny8U74Qdq+DPClMT1WH5VRPYyz8dvpOOF5ev7XRKZgMpHUrVRUM57H?=
 =?iso-8859-1?Q?drHMir/m81mnZUrO61hhqDTTgMMgDr1eZurJ/3To8JUbRI1TGrndk+OVc9?=
 =?iso-8859-1?Q?P0rtYAwHILCi1mTb8wkyhRaeWlS6x5PgSVczjh64zPzYbebmDFfkWCi7lY?=
 =?iso-8859-1?Q?8OWwNVb4Dw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcbe1e5-1f3d-4043-c5d3-08de7366a05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:14.6953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lw3W0lEdAp76MnUR8KrzcAr8UkCbWwLubVWLGaRGw6kxRRYtLPjp/2dmmpKggLivvVTtFKNjcfDh6/f9J3M/JiL/639US2dZ/OY0pIm6tek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

v1:=0A=
  The initial patch series was based on work by Joe Komlodi <komlodi@google=
.com>.=0A=
=0A=
  This series adds I3C bus support to QEMU and adds more functionality to t=
he=0A=
  Aspeed I3C controller.=0A=
=0A=
  This implementation is a basic implementation that introduces IBIs=0A=
  (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't supp=
ort=0A=
  multi-controller buses or HDR transfers.=0A=
=0A=
  First we add the I3C bus and controller model. With that added we extend=
=0A=
  the functionality of the Aspeed I3C controller so it can do transfers=0A=
  and handle IBIs.=0A=
=0A=
  Next, we add a mock I3C target. It's intended to be a very simple target=
=0A=
  just to verify that I3C is working on the guest. Internally, we've used i=
t=0A=
  on Linux to verify that i3C devices can be probed and can send/receive da=
ta=0A=
  and IBIs.=0A=
  This target is sort of like an EEPROM, and it can also send IBIs upon=0A=
  reception of a user-defined magic number.=0A=
=0A=
  Lastly we add  hotplugging support. The hotplugging doesn't do anything t=
oo=0A=
  complicated, it just adds the device attempting to hotplug to the bus. It=
=0A=
  is the device's responsibility to hot-join and go through the DAA process=
=0A=
  to participate on the bus.=0A=
=0A=
v2:=0A=
  Jamin Lin <jamin_lin@aspeedtech.com> has taken ownership of the I3C patch=
=0A=
  series for upstream submission.=0A=
=0A=
  Changes in this version include:=0A=
=0A=
  1. Added I3C functional tests.=0A=
  2. Updated patch 4 to refine register field definitions.=0A=
  3. Updated patch 7 to correct read-only register field masks.=0A=
=0A=
v3:=0A=
  1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
  2. Fix a typo=0A=
  3. Fix ASPEED mail server issue=0A=
=0A=
v4:=0A=
  1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com> at the end of =
each patch.=0A=
=0A=
v5:=0A=
  1. Address review feedback by updating the I3C bus and device to use the=
=0A=
   DEFINE_TYPES() macro instead of an explicit type registration function.=
=0A=
  2. Rename variables to `parent_obj` for the parent object and `parent_cla=
ss`=0A=
   for the parent class to comply with QEMU QOM coding style guidelines.=0A=
=0A=
v6:=0A=
  1. Add I3C maintainers and reviewer=0A=
=0A=
Jamin Lin (3):=0A=
  hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and align parent_obj=0A=
    naming=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test=0A=
  MAINTAINERS: Add I3C maintainers and reviewer=0A=
=0A=
Joe Komlodi (19):=0A=
  hw/misc/aspeed_i3c: Move to i3c directory=0A=
  hw/i3c: Add bus support=0A=
  hw/i3c: Split DesignWare I3C out of Aspeed I3C=0A=
  hw/i3c/dw-i3c: Add more register fields=0A=
  hw/i3c/aspeed_i3c: Add more register fields=0A=
  hw/i3c/dw-i3c: Add more reset values=0A=
  hw/i3c/aspeed_i3c: Add register RO field masks=0A=
  hw/i3c/dw-i3c: Add register RO field masks=0A=
  hw/i3c/dw-i3c: Treat more registers as read-as-zero=0A=
  hw/i3c/dw-i3c: Use 32 bits on MMIO writes=0A=
  hw/i3c/dw-i3c: Add IRQ MMIO behavior=0A=
  hw/i3c/dw-i3c: Add data TX and RX=0A=
  hw/i3c/dw-i3c: Add IBI handling=0A=
  hw/i3c/dw-i3c: Add ctrl MMIO handling=0A=
  hw/i3c/dw-i3c: Add controller resets=0A=
  hw/i3c/aspeed: Add I3C bus get function=0A=
  hw/i3c: Add Mock target=0A=
  hw/arm/aspeed: Build with I3C_DEVICES=0A=
  hw/i3c: Add hotplug support=0A=
=0A=
 MAINTAINERS                                   |   12 +=0A=
 meson.build                                   |    1 +=0A=
 hw/i3c/trace.h                                |    2 +=0A=
 include/hw/arm/aspeed_soc.h                   |    2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h         |   31 +-=0A=
 include/hw/i3c/dw-i3c.h                       |  199 ++=0A=
 include/hw/i3c/i3c.h                          |  277 +++=0A=
 include/hw/i3c/mock-i3c-target.h              |   52 +=0A=
 hw/i3c/aspeed_i3c.c                           |  258 +++=0A=
 hw/i3c/core.c                                 |  664 ++++++=0A=
 hw/i3c/dw-i3c.c                               | 1862 +++++++++++++++++=0A=
 hw/i3c/mock-i3c-target.c                      |  298 +++=0A=
 hw/misc/aspeed_i3c.c                          |  383 ----=0A=
 hw/Kconfig                                    |    1 +=0A=
 hw/arm/Kconfig                                |    3 +=0A=
 hw/i3c/Kconfig                                |   15 +=0A=
 hw/i3c/meson.build                            |    6 +=0A=
 hw/i3c/trace-events                           |   48 +=0A=
 hw/meson.build                                |    1 +=0A=
 hw/misc/meson.build                           |    1 -=0A=
 hw/misc/trace-events                          |    6 -=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +=0A=
 22 files changed, 3722 insertions(+), 412 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (53%)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 include/hw/i3c/i3c.h=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/aspeed_i3c.c=0A=
 create mode 100644 hw/i3c/core.c=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
 delete mode 100644 hw/misc/aspeed_i3c.c=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
-- =0A=
2.43.0=0A=

