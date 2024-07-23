Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6CDC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9hA-0003PP-8T; Tue, 23 Jul 2024 03:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sW9h6-0003Bt-LE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:12:21 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sW9h3-0002Co-Sr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721718738; x=1753254738;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=e6VG3rXqFSMQCP3lfdUcLvX7ASXvWK/KX5hTWhXWfFU=;
 b=wjOyd2ZPWmNoyV/hjVC5cKAFQEXnKwU2+trcD4NT0z6F3wZM4ndgTlfz
 mucnWYFVCUbTUHKSE69eTdAOqJYx2nZtsavvhnxkTVrP7PkXJvAMXahmY
 7597nrHl6cRArQ2Q+oOGDmC5BANTeYNqzi6fpMoSl0o8J66wV8wTCdEt9
 A5AXSgi1u7AEAu8/d/++5YIl71OdpS54fQQjMSBCyaVRdrm/DXGoETG44
 00Ed3UpfwFhlXYugWtJQpJKZSveSPVd5cZS3NpUrYjrGdkmyjGg1F5kB4
 h946U/4zWb2FffDJDokrkDv54IjS/FRb1JaWMHdLkLfu6yKGT6qgN4iKX g==;
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; d="scan'208";a="17016934"
X-MGA-submission: =?us-ascii?q?MDFBjJ10eDgMZFHfg5wN0L3fVvTw28qqC4+LZj?=
 =?us-ascii?q?qork7nsqgh3uLD5+p1duagmF+W3Xb4v2LeU2aDwQBF6jhOUtvTxRVgXX?=
 =?us-ascii?q?NeFJwxQm7bihprNxgq0H8+pGh92XSvUZW2c2y+q+Z5oDb3ExX6jOTD88?=
 =?us-ascii?q?LtyDnnyKe+A2gavXX3zv6plQ=3D=3D?=
Received: from mail-vi1eur05lp2168.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.168])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 09:12:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1JKVxkRBSLupHSPcVcOz/nMfSFB0ulJMYUQj5n7uuhnA9d21jLBOh/BgUWxy9ToccExfofn9gj7LzmZ6q9mhO1cispWZ+eWEwMO7rJYv+6N/fNlSQE6PNtJSXQBemLYxTqwbcbSPkiQGMeRFNwb4GFKEV8cEsBciAV1gg7yppxQYzVdMqzuBD4lDM7cm/IA1Tf42AlGtsbjHHk40b6qz+ZjxNf+G7SHX5VYheuhH7Qx2KYB2iY4HCTX8BlVD6jstivS2AHpueVjxZjEJ6NyGiYIgvwrKkKWN8SHPKGUBexS8Y9aMQRInPCGDbxPfqyOcXkZMOcOeg2L7bygjdsroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6VG3rXqFSMQCP3lfdUcLvX7ASXvWK/KX5hTWhXWfFU=;
 b=jWQXFaw5CdIbDWS7htA/UJBlpLbNOS7epzquhDFLKi/sYKmBYXhU1I6Z77KCbO4hC68x7SkVbsQWXfb47O6613wqbMLi8euvjnh7BsyWQRgLCz6Bc8Bl24hRGlGzuz+J+oJUzzf1FrYgq1De/CE4dyLlWVik08l5M0I2ZOU6s3IFMiy6aMKEkSPwEdD+CYj5SBlpn3le5mYGbIS5ER2DgPcyvP0ZFahAcG0BUY7ZzspHtfb+Ma8AmeD37DFs8QB/zHRyIRH8fAVtepHRu4vtvswAel6K/N7vdRMS98ThL3pyzrYBCBXODnrpusuHbIMWxG6M3F1HWibIgfHLeRbCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6VG3rXqFSMQCP3lfdUcLvX7ASXvWK/KX5hTWhXWfFU=;
 b=p88gvWpqJlsHHo3FFAxrm/woN2tavxyhD6RlKyM8i7FNX8MWlJG4WI7leyCAsSMo+GnNPwBXnXz04MayTzzKoCB/QW7GzAw5XU5bJWQVlZ4F/j0faUHQAvTfOf85HURn/QUDNOHWY4f1HDvkezk1WQ/V52fzQhEyBqd744K6QXAUJzJwr7xNb7rA8okYB61+IHAqF09sRz2rlqWLsPT1wv5+9MFknlJaVPaR7cRUj5tvGhsCSDaLVnmUvO0DizD8gwQZNwu9j+j8uSiwEtqc5fy1uIApL9Fd2tu42dNLqNY00aTN+TTUU0v0VfapLjWTtyQkyIZFukb/wBRw0aDzhg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV1PR07MB9168.eurprd07.prod.outlook.com (2603:10a6:150:81::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Tue, 23 Jul
 2024 07:12:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 07:12:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Topic: [PATCH v1 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Index: AQHa2OtJ3METS/wqCEuDxxqdCprzsLID7WOA
Date: Tue, 23 Jul 2024 07:12:10 +0000
Message-ID: <a98dd9f8-c5d4-4cba-923c-f85ee4d0de73@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-10-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-10-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV1PR07MB9168:EE_
x-ms-office365-filtering-correlation-id: 7196f0fb-ce04-48e6-7273-08dcaae6c4d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VGFMMGs0Zmc1WVovWXFXa3Y3SXNMZVZNOEpINzNJMVBpNHBVa1hBVys1Snl2?=
 =?utf-8?B?ZzI3SXZCTXlrQm5NVzMwQkRJQU9icnI3S1N6VkpFV1QvMkRZdG9ZSERGVEt6?=
 =?utf-8?B?MzRLMkh5TGUrdVAvdXh2aGVuVmV5eUZQQ3ZoWVlwVVZKZ25YZ2xOa3ZWVGFX?=
 =?utf-8?B?MG9vSEIraS83MUJ3NW52NVV3QkM4SjNBbFlzNnByWWxheVJIelRDV3J1dzhu?=
 =?utf-8?B?ODAyZUw2ZGZzVWRIZ3hNWVA4YVRIcVZETEhWUDFzZ2FHd2F3NTRyNUJhV2FD?=
 =?utf-8?B?YXZ5dGNYaU11Z0FaY0xnZXFpM0VFT25WSjloOEYxUk9hd2lVUU1UaTdEMkk2?=
 =?utf-8?B?emh2Q0ZEdElXdnBwa1RXSEpvL2wrOGVzakxpVE1iT21ZeEFjaTFVdm5MaFoy?=
 =?utf-8?B?b0VDQ1NhM3V3N3N0SEQ3Nm1vNkpIemhuUHAyMjR4cktnaE1KczJ6Mkl6MkpV?=
 =?utf-8?B?Y0dGTG9POWpadTdzaE1mV2pQc0xvd2ZCV0p4MXRyZTVMcTZ6NkZac2VGVTFP?=
 =?utf-8?B?M2dEWGF1NjRmc1RxNXIzVFA2UytINWRJQ2VwalhMSU8vQjBTRWRBbTVYVEN1?=
 =?utf-8?B?Wld0aDhNSlVORnlITm1PaER4RjZOOXE2MnI2b2o0cm9VejNpZUV1SHJ4cTgv?=
 =?utf-8?B?aXkvUTFTaXBmdmc3NU9OVkNnaVhaRUdrVWdNdG9VekdZblJRSjk2RCs5Zk54?=
 =?utf-8?B?bkwyaDZnSEsrakkxODNjY2FNTHdmV0drYlNXSEp5ZUUzZnJNd3UwR0Q4YkFv?=
 =?utf-8?B?OUFiOGhaZnR1MGJtZGNOTTJRVEdGWmxBZG9GNTF2c2hPUmFPbXF0Rzk5NlpN?=
 =?utf-8?B?dnNqT1BkNldPQ1RENkNVSWFUeEFvc1hqdE9UcmhBNnNGc0VvZkUvNGhKbGF6?=
 =?utf-8?B?MWYrVE5Rdm5yMVAyWjREWkhhQjFRSDFUSGlPQVBNZUJTVVYrblpvSGc5SjUz?=
 =?utf-8?B?MVJqcWI4dlg4TlNiQUZqYkdmbGNjcEFsUkZYUFRuZ2gyVlNJVVk5elAwUnp1?=
 =?utf-8?B?MldwcFhQc0NZZXVIdVIwWXVBR0FicXplVXE0OFkrZEFWTVpONEhJTDhPQXlB?=
 =?utf-8?B?WXJTVVNyd3Q0OW1ZTWQvT2x2ZEQwc2VwTGJ0WlJiRUNaRXk3dWIzS3o2cnox?=
 =?utf-8?B?TjNGMEtxWk9QY05IektPMktBZDlLUm5uN2ZMVW1oek5LNXI2TkZHVEc2UFg0?=
 =?utf-8?B?YVB1eVNtVWhQT3FCamE5WUIyRm1aUGJBaG83UitWUjVYSzliZnRpRTRCamRN?=
 =?utf-8?B?R2NUclMzdjdUQkc2WmFTWHdoNVJDWGhZMlFBZ1JZbTNycVNxWjNFMXQ0cnJQ?=
 =?utf-8?B?VkIxMjF2OGpVNm00MCsrV3BYQ2FONGhWUzlvNSswRGE0S1Z4clVYS3BreEMx?=
 =?utf-8?B?RFVZbm9KVDBqV2dPL25mRFp0Y1JMbTBINlY5ekhpaVc4aHVacjdncTZHNjdW?=
 =?utf-8?B?MlNNd1hVSWVvTVg1M0ZWNjJUUjBhNUJZQWhhWi8rU2gxVWlGTExMTU5LVVFO?=
 =?utf-8?B?WEJTOTZTVFdrSDRXckduZGpUUVA3Y0QxOHVoOG0zN0hIUzVzeDhHZnVnT29l?=
 =?utf-8?B?K0Q1amYyM04wSDFDbURzZkZtaEllTUNBMTA2M3J3RnRPS2hRWUFmV3k2aGpU?=
 =?utf-8?B?azNuMXU4QkJPc2pjR1pNdmVUSEhacDZ4UnFBYldjRWZWTWUyT1ZINXVCdk43?=
 =?utf-8?B?eEVYMTNsa3hXRkI3L2tSNWl2dFNkQWl1akJRZGlyOVZCSUd0TE94S1RPYXlz?=
 =?utf-8?B?T3NpT2JsMUMzb3pLUmxrdHhUajY5M1djVHZCYVZHZ3ptZktjSkVLQUwxVEhl?=
 =?utf-8?B?emYxdk5LdVVWMWdHN1BWY0l5VUVyUmdxS0NVVWdkR04rL3hJUUhaTDVldGxv?=
 =?utf-8?B?dktLTjVQUVF6K1lkMG9EZVVhcUNvazhxWFl5aGVhMEpIc1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkVmYjRWWldZWW9xbXdmZ2F6bUk2ZmtBZ05KY29RUEhOcHA3eXRPS25hUStJ?=
 =?utf-8?B?R2lSdGhndC9wS3BQcWNxSjFhenFFK2VaSjZzT1VYWUkwSzhYUTVkUmNkeWZG?=
 =?utf-8?B?L1hCME4rL0Fvc2RXOXpnZ1RGSDhuT0YxSVlOMDV0RDBGNUJOTnliYnhaS1FG?=
 =?utf-8?B?R0N2R0UzTGYvM0lQZzNmTkNURWVtZjA4R2NwbVlla25QeDFuR3R2Ni9rTE1v?=
 =?utf-8?B?OHRzek5JcldMSFEyQVFOQVRzazNORXRvRXd2OFFyUm1jb1QvTGphci9nTHEv?=
 =?utf-8?B?dk9iYlVxVWk3YllzeVlsTll1RlJQQUtUVDNRalZGWWhKN0pWQm8yYmJzQkR4?=
 =?utf-8?B?QnRrb1p3dmZLRFNib2s2aWhYb213eWRNNTZ0WTJxd09OcVgrVy9YczVNUGUz?=
 =?utf-8?B?TTc1UmVZRWwxMFdDam9FZm5LK0c1K3g0YUtYTTI5QnVxdWtZWm0rNlEvZTNr?=
 =?utf-8?B?dmpKaG1mbXpRSmFmVTAyRHRBTDJqcUhFbXpuTVFIOEdSckpHcXJHOUtoSVB2?=
 =?utf-8?B?S08yRERza2FiOFUyWmcrWGNabXdLcm1LSStOdFZIMVpvVGMydjJYRGFaYk1a?=
 =?utf-8?B?TGVYTjdVMGNueWZpdmo1aGJob3kxYmliRGIrZmw2S1VpN3RjRG1MZWx5Z0Vh?=
 =?utf-8?B?VmIrQzBQSnFBcWxKd3A0QkhQSkQwd2pxeERseFIrWXdUV0lZYmdCQkFRMzFG?=
 =?utf-8?B?cldaNnBYYS9SWUc4TTZtZlJGNXU5WEpURUcrYnhGUHQ3QlNINWZjVFJQaTV3?=
 =?utf-8?B?cmpSRjdUU3NkSlNBNUMwU2VkNDJZbUpGQ05JNGpZS2JPNTFvSDEvRXo2RHh3?=
 =?utf-8?B?VUMvNndqVmhWbjBqalBFK1owWFhlclAzTW1ldmxHTEdwWm9TY2pHNXdBd3Vi?=
 =?utf-8?B?MTRFTEI0RncrbzM0RFJnRWdJcyt3QzcwRU9vNHNpb2pHbVZEOUxzMzdMMVJn?=
 =?utf-8?B?cHNOR2Y1MFY5WVg1amNJM3hILzJ0UW1PMVY1YmhDL3VXdnZjYVk2ck5nT0VG?=
 =?utf-8?B?UkllL0FsS2c1TzAwN2xzSUcrVFplckJ5SExxMHV0MzU1QTRaMjZ3cStXMHli?=
 =?utf-8?B?QWRabGJkdGtYWnlxNFRUQWRLekczVEVxME56dC9vcDdRdURoK0hESXhtWG5l?=
 =?utf-8?B?U3BROVZRTWQzVnJPbXFBS1BESkZzUnhaakVsZ1lzOHYvK2U4WWg0WVNaKzlr?=
 =?utf-8?B?K1pLUFlxUjVqbUdrK1JtRTV4T3BCY09VS0NSWmkxSENoVElxaDdHK3RaWVpZ?=
 =?utf-8?B?ZnRIcjRobmw0K1JvM3R2cGxqNzA4b1pJOWFMYTZBYjFNdmI0UTVYdC9LSG1r?=
 =?utf-8?B?WUhQd3paZUZlTUo2WG56SFhreDlaSFhHT1JGQ0J6ZHpuSkZXNXRueEZLeVVK?=
 =?utf-8?B?ZnlVWWtUbCtKaDFKZzFjcXcySmUwVFZ5cG1OYjdoYTVkalJBbHhZTlpWanR4?=
 =?utf-8?B?aHhsVDg0Tk50VXpZeXM2Tyt0cXpvQVZDTWcyV2pZRWZTSEM2Nm8wdzZpSGpB?=
 =?utf-8?B?bXN4MHVmcVJBdDRudlU4a2Q4ZGd2TWpKb3ZUa242ak10Ti9ieGdZbmpLQlRy?=
 =?utf-8?B?YXNuL3ZkdWJrb280N2hVUkRtTENvakI4ZHJoNjVUc2JhWUhhNUtaSWpJd2ZY?=
 =?utf-8?B?UWNNLzU0MEQ4SDV5VG9MVlh2UHdCWlRKbVZhWTBGNE14V2NabWR3OVZFZ0N6?=
 =?utf-8?B?enNSRjJPUjlRd0xzMHBYTmRxMU9zMEo3OUZOeHVOc1BxcG05RW5QNlRDNFVt?=
 =?utf-8?B?YTYwRDZmMkVLSjNOZENzOXZTbDQySzZId1FHaG53VXNkVVFmalNoMDVXZlRo?=
 =?utf-8?B?Z2NEWE5zU09WTEwyalphUjBQNDc2bk1xR01ZVGJxVmZuaGlMR1pPZTRsZTBZ?=
 =?utf-8?B?RWhsaUZwSDNPUXh4RVBwODFGeXVmZTcxejNNRzl3WW81Y25leVFvNU5hM0gy?=
 =?utf-8?B?czBKdU9OMkV5UkFmQThLTEhIRjBYRVR4bWc1VExxNnJCaUNPNEZLUXpQZXdJ?=
 =?utf-8?B?UkpZYjJOajRJMU42RzNRTzl6ME1VRUVGU0h0RmREUUZZQW1acTk2ZzZMVWRH?=
 =?utf-8?B?Zk9SMWx6VWtnWk82cFRmQVVjc2NtblpCK3owQld3eDdoVm8zdGhIbWRiNjJ5?=
 =?utf-8?B?aUw2L2IxdktRNFZyNUN5aVNxZjNwZUg1TWNTWVFRRXpSMktnMG5kVjRaSndt?=
 =?utf-8?Q?owtX4M5Cjfh26wZL1LrCYus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B2ED7AA0B3EF4CB144763DA745988C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7196f0fb-ce04-48e6-7273-08dcaae6c4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 07:12:10.1023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfeXruM9Fn4e4XGJsx9cHlCTj8oC9L1Xd4mWWW38lDyyPqr0U9Azji3qG3LLqMFEztFwJPnmvtvanVc7wQ94QvkQLVscXi065GOcW0h6RbS6NShp9KlJr8w4Jc87Twbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9168
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gQWNjb3JkaW5nIHRv
IHNwZWMsIFBhZ2UtU2VsZWN0aXZlLXdpdGhpbi1Eb21haW4gSW52YWxpZGF0aW9uICgxMWIpOg0K
Pg0KPiAxLiBJT1RMQiBlbnRyaWVzIGNhY2hpbmcgc2Vjb25kLXN0YWdlIG1hcHBpbmdzIChQR1RU
PTAxMGIpIG9yIHBhc3MtdGhyb3VnaA0KPiAoUEdUVD0xMDBiKSBtYXBwaW5ncyBhc3NvY2lhdGVk
IHdpdGggdGhlIHNwZWNpZmllZCBkb21haW4taWQgYW5kIHRoZQ0KPiBpbnB1dC1hZGRyZXNzIHJh
bmdlIGFyZSBpbnZhbGlkYXRlZC4NCj4gMi4gSU9UTEIgZW50cmllcyBjYWNoaW5nIGZpcnN0LXN0
YWdlIChQR1RUPTAwMWIpIG9yIG5lc3RlZCAoUEdUVD0wMTFiKQ0KPiBtYXBwaW5nIGFzc29jaWF0
ZWQgd2l0aCBzcGVjaWZpZWQgZG9tYWluLWlkIGFyZSBpbnZhbGlkYXRlZC4NCj4NCj4gU28gcGVy
IHNwZWMgZGVmaW5pdGlvbiB0aGUgUGFnZS1TZWxlY3RpdmUtd2l0aGluLURvbWFpbiBJbnZhbGlk
YXRpb24NCj4gbmVlZHMgdG8gZmx1c2ggZmlyc3Qgc3RhZ2UgYW5kIG5lc3RlZCBjYWNoZWQgSU9U
TEIgZW50aWVzIGFzIHdlbGwuDQo+DQo+IFdlIGRvbid0IHN1cHBvcnQgbmVzdGVkIHlldCBhbmQg
cGFzcy10aHJvdWdoIG1hcHBpbmcgaXMgbmV2ZXIgY2FjaGVkLA0KPiBzbyB3aGF0IGluIGlvdGxi
IGNhY2hlIGFyZSBvbmx5IGZpcnN0LXN0YWdlIGFuZCBzZWNvbmQtc3RhZ2UgbWFwcGluZ3MuDQo+
DQo+IEFkZCBhIHRhZyBwZ3R0IGluIFZURElPVExCRW50cnkgdG8gbWFyayBQR1RUIHR5cGUgb2Yg
dGhlIG1hcHBpbmcgYW5kDQo+IGludmFsaWRhdGUgZW50cmllcyBiYXNlZCBvbiBQR1RUIHR5cGUu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0K
PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiBpbmRleCBmZTkwNTdjNTBkLi5iODQz
ZDA2OWNjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiAr
KysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiBAQCAtMTU1LDYgKzE1NSw3IEBA
IHN0cnVjdCBWVERJT1RMQkVudHJ5IHsNCj4gICAgICAgdWludDY0X3QgcHRlOw0KPiAgICAgICB1
aW50NjRfdCBtYXNrOw0KPiAgICAgICB1aW50OF90IGFjY2Vzc19mbGFnczsNCj4gKyAgICB1aW50
OF90IHBndHQ7DQo+ICAgfTsNCj4NCj4gICAvKiBWVC1kIFNvdXJjZS1JRCBRdWFsaWZpZXIgdHlw
ZXMgKi8NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KPiBpbmRleCAyMTBkZjMyZjAxLi44ZDQ3ZTViYTc4IDEwMDY0NA0KPiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
IEBAIC0zMDUsOSArMzA1LDIxIEBAIHN0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlf
cGFnZShncG9pbnRlciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPiAgICAgICBWVERJT1RMQlBhZ2VJ
bnZJbmZvICppbmZvID0gKFZURElPVExCUGFnZUludkluZm8gKil1c2VyX2RhdGE7DQo+ICAgICAg
IHVpbnQ2NF90IGdmbiA9IChpbmZvLT5hZGRyID4+IFZURF9QQUdFX1NISUZUXzRLKSAmIGluZm8t
Pm1hc2s7DQo+ICAgICAgIHVpbnQ2NF90IGdmbl90bGIgPSAoaW5mby0+YWRkciAmIGVudHJ5LT5t
YXNrKSA+PiBWVERfUEFHRV9TSElGVF80SzsNCj4gLSAgICByZXR1cm4gKGVudHJ5LT5kb21haW5f
aWQgPT0gaW5mby0+ZG9tYWluX2lkKSAmJg0KPiAtICAgICAgICAgICAgKCgoZW50cnktPmdmbiAm
IGluZm8tPm1hc2spID09IGdmbikgfHwNCj4gLSAgICAgICAgICAgICAoZW50cnktPmdmbiA9PSBn
Zm5fdGxiKSk7DQo+ICsNCj4gKyAgICBpZiAoZW50cnktPmRvbWFpbl9pZCAhPSBpbmZvLT5kb21h
aW5faWQpIHsNCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKw0KPiArICAg
IC8qDQo+ICsgICAgICogQWNjb3JkaW5nIHRvIHNwZWMsIElPVExCIGVudHJpZXMgY2FjaGluZyBm
aXJzdC1zdGFnZSAoUEdUVD0wMDFiKSBvcg0KPiArICAgICAqIG5lc3RlZCAoUEdUVD0wMTFiKSBt
YXBwaW5nIGFzc29jaWF0ZWQgd2l0aCBzcGVjaWZpZWQgZG9tYWluLWlkIGFyZQ0KPiArICAgICAq
IGludmFsaWRhdGVkLiBOZXN0ZWQgaXNuJ3Qgc3VwcG9ydGVkIHlldCwgc28gb25seSBuZWVkIHRv
IGNoZWNrIDAwMWIuDQo+ICsgICAgICovDQo+ICsgICAgaWYgKGVudHJ5LT5wZ3R0ID09IFZURF9T
TV9QQVNJRF9FTlRSWV9GTFQpIHsNCj4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgfQ0K
PiArDQo+ICsgICAgcmV0dXJuIChlbnRyeS0+Z2ZuICYgaW5mby0+bWFzaykgPT0gZ2ZuIHx8IGVu
dHJ5LT5nZm4gPT0gZ2ZuX3RsYjsNCj4gICB9DQo+DQo+ICAgLyogUmVzZXQgYWxsIHRoZSBnZW4g
b2YgVlREQWRkcmVzc1NwYWNlIHRvIHplcm8gYW5kIHNldCB0aGUgZ2VuIG9mDQo+IEBAIC0zODIs
NyArMzk0LDcgQEAgb3V0Og0KPiAgIHN0YXRpYyB2b2lkIHZ0ZF91cGRhdGVfaW90bGIoSW50ZWxJ
T01NVVN0YXRlICpzLCB1aW50MTZfdCBzb3VyY2VfaWQsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MTZfdCBkb21haW5faWQsIGh3YWRkciBhZGRyLCB1aW50NjRfdCBwdGUs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90IGFjY2Vzc19mbGFncywg
dWludDMyX3QgbGV2ZWwsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHBhc2lkKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCwg
dWludDhfdCBwZ3R0KQ0KPiAgIHsNCj4gICAgICAgVlRESU9UTEJFbnRyeSAqZW50cnkgPSBnX21h
bGxvYyhzaXplb2YoKmVudHJ5KSk7DQo+ICAgICAgIHN0cnVjdCB2dGRfaW90bGJfa2V5ICprZXkg
PSBnX21hbGxvYyhzaXplb2YoKmtleSkpOw0KPiBAQCAtNDAwLDYgKzQxMiw3IEBAIHN0YXRpYyB2
b2lkIHZ0ZF91cGRhdGVfaW90bGIoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzb3VyY2Vf
aWQsDQo+ICAgICAgIGVudHJ5LT5hY2Nlc3NfZmxhZ3MgPSBhY2Nlc3NfZmxhZ3M7DQo+ICAgICAg
IGVudHJ5LT5tYXNrID0gdnRkX3B0X2xldmVsX3BhZ2VfbWFzayhsZXZlbCk7DQo+ICAgICAgIGVu
dHJ5LT5wYXNpZCA9IHBhc2lkOw0KPiArICAgIGVudHJ5LT5wZ3R0ID0gcGd0dDsNCj4NCj4gICAg
ICAga2V5LT5nZm4gPSBnZm47DQo+ICAgICAgIGtleS0+c2lkID0gc291cmNlX2lkOw0KPiBAQCAt
MjA3MSw3ICsyMDg0LDcgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERB
ZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+ICAgICAgIGJvb2wgaXNfZnBkX3Nl
dCA9IGZhbHNlOw0KPiAgICAgICBib29sIHJlYWRzID0gdHJ1ZTsNCj4gICAgICAgYm9vbCB3cml0
ZXMgPSB0cnVlOw0KPiAtICAgIHVpbnQ4X3QgYWNjZXNzX2ZsYWdzOw0KPiArICAgIHVpbnQ4X3Qg
YWNjZXNzX2ZsYWdzLCBwZ3R0Ow0KPiAgICAgICBib29sIHJpZDJwYXNpZCA9IChwYXNpZCA9PSBQ
Q0lfTk9fUEFTSUQpICYmIHMtPnJvb3Rfc2NhbGFibGU7DQo+ICAgICAgIFZURElPVExCRW50cnkg
KmlvdGxiX2VudHJ5Ow0KPg0KPiBAQCAtMjE3OSw5ICsyMTkyLDExIEBAIHN0YXRpYyBib29sIHZ0
ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVz
LA0KPiAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsN
Cj4gICAgICAgICAgIHJldF9mciA9IHZ0ZF9pb3ZhX3RvX2ZscHRlKHMsICZjZSwgYWRkciwgaXNf
d3JpdGUsICZwdGUsICZsZXZlbCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZyZWFkcywgJndyaXRlcywgcy0+YXdfYml0cywgcGFzaWQpOw0KPiArICAgICAgICBwZ3R0
ID0gVlREX1NNX1BBU0lEX0VOVFJZX0ZMVDsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAg
IHJldF9mciA9IHZ0ZF9pb3ZhX3RvX3NscHRlKHMsICZjZSwgYWRkciwgaXNfd3JpdGUsICZwdGUs
ICZsZXZlbCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZyZWFkcywg
JndyaXRlcywgcy0+YXdfYml0cywgcGFzaWQpOw0KPiArICAgICAgICBwZ3R0ID0gVlREX1NNX1BB
U0lEX0VOVFJZX1NMVDsNCj4gICAgICAgfQ0KPiAgICAgICBpZiAocmV0X2ZyKSB7DQo+ICAgICAg
ICAgICB2dGRfcmVwb3J0X2ZhdWx0KHMsIC1yZXRfZnIsIGlzX2ZwZF9zZXQsIHNvdXJjZV9pZCwN
Cj4gQEAgLTIxOTIsNyArMjIwNyw3IEBAIHN0YXRpYyBib29sIHZ0ZF9kb19pb21tdV90cmFuc2xh
dGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KPiAgICAgICBwYWdlX21h
c2sgPSB2dGRfcHRfbGV2ZWxfcGFnZV9tYXNrKGxldmVsKTsNCj4gICAgICAgYWNjZXNzX2ZsYWdz
ID0gSU9NTVVfQUNDRVNTX0ZMQUcocmVhZHMsIHdyaXRlcyk7DQo+ICAgICAgIHZ0ZF91cGRhdGVf
aW90bGIocywgc291cmNlX2lkLCB2dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHBhc2lkKSwNCj4g
LSAgICAgICAgICAgICAgICAgICAgIGFkZHIsIHB0ZSwgYWNjZXNzX2ZsYWdzLCBsZXZlbCwgcGFz
aWQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgYWRkciwgcHRlLCBhY2Nlc3NfZmxhZ3MsIGxl
dmVsLCBwYXNpZCwgcGd0dCk7DQo+ICAgb3V0Og0KPiAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMp
Ow0KPiAgICAgICBlbnRyeS0+aW92YSA9IGFkZHIgJiBwYWdlX21hc2s7DQo+IC0tDQo+IDIuMzQu
MQ0KPg0K

