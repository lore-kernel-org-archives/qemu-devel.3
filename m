Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7ECC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPO8t-0005az-0B; Thu, 04 Jul 2024 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8r-0005aI-IA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:13:01 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8k-0002sV-2y
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720105973; x=1751641973;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YoEDiqSXeBOMuFcUpS2ye/tE0awOTVdmwpSMPRrvMks=;
 b=QdWBSNSjZs6cuvvIVWe+eUzNZHxn2NXl4QmH02XP5pbqUKXQlbtqZ/+s
 dNcesyTIaIIZQ8LbxVzj+NnRjdQZw3ckXP4y7+8xGLG+G3o7ipcK0LMtg
 tP6s6aD9SejF4w61/90qe62y+uQhl+CrCOwdc7PnBBkS2E9eNaJUpShZC
 pJBomOvKLmpo54mI+y2HppvspJyyjIBgHnjts/u5V7jyW7VkIXvKuz9hm
 /R1t+YcJ51QbuEw9OkLak2859fyWMrfsxjegpvGvqhydqYLdcvCzxphD3
 jQ1MIJy1mdfcWds/wpBSeqGspvN5E+IJ2j6zXmGpH17WaovM+t7QVbytJ Q==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15910928"
X-MGA-submission: =?us-ascii?q?MDGzkHGvFftBHh6nyWM5Tui3e99VGUub4u6NAl?=
 =?us-ascii?q?6eEdQBAlmFy8RlRwoiCOqE7IE2xNzdl+4HdR/BEcvUj/uwEMrZM0o9tc?=
 =?us-ascii?q?5XBxV9xiL/B1rzVSKk6ym6P4IvbGsCtRLAIxbDG1xew8S/gcORAGy7ll?=
 =?us-ascii?q?51eAdXUAGnjHDDS8mcSe4BUA=3D=3D?=
Received: from mail-am0eur02lp2238.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.238])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 17:12:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8H0koQKgoAHlkLEZJy3O8DTw5zyS44NjwFjmQIx7FKmM3CEKZcwiZ3l0gcdRToyXY0wTps3swJ38euwEmMaGi3LYMop2MuEvfj89jsZA7ulrvGAoKemZ6wSNV5+rIP3ReMmx97oJ5zsHi8JjgFMmPz6oGgTsrKhtEU3/06UEtiEfeplgn2ttQuYlmqJ2I+S4pZ3XuFSdcFCFUj+k8nIg8pt+F/K2gP3jui+xIVkaN0vjhqIeONgYqGviv/4TUg+HU7+oUWL8LWcbsseGxmuMt8n5phMWIeTZ7dCIbtioOE2+7jZ4KmhyVNTKazl8EYV/BVb3iEgPALqlNg9z+DusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoEDiqSXeBOMuFcUpS2ye/tE0awOTVdmwpSMPRrvMks=;
 b=NqGJ1ISk5ekE7nTr5Gu/XgPvjA/x7etT7l8sA4rkxM/hnUSz+e4IV5KvefqEh5Wd+qKKUR0RNI1zYlMz7tbHcqZqiFs3NRhOEiv/xNQ0RB97wYceXoJJ+WznH3ydEmyXWiUH5S6c0RUBNxjEACUXwL+mEwo0beOSBHpVGoe5+ZuD1m0SYg5F+I5H3xICsNxnruZS17NgLpW2VZDEf2caj+8B/i/Ziqjz0Cz/jx/eS/6VwMuLsU37dhhQsSKu9MOIuamKPk3CZ2/QdnCMO2N1tyUX+AWKVTHCwWZiQPHS/+hf5zo3hqEUQC8igNAw4H0NcdeCEZXOdHbks4rXL6qKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoEDiqSXeBOMuFcUpS2ye/tE0awOTVdmwpSMPRrvMks=;
 b=sRstGMeOliD8UB1IIKtqlDWe4FrVrBNFnY4r/o8Vt1B1CbSQYF2ZPnO1+INnbT1UIFyaLCumLLynST6Hrhnqn8wrXbd360UtCUXa9F4N9fZWyG8jTcL/D3EkBusUrANlurNBJuB+ty2GsWILX5X9851BMPjGPrrbLhv91JSAHa7x6OhUomIg5CkGS4yd6o9DPdYwJCc25Ymj6Y0srZp1zrpgXdcimmxTDKAQcVxpCF+JcfDvp0cwTO9qeyqijRggrqcwoIO8jn9XoBago45t7k+NDpeMc3O0/v0CiQodSTn87XzT0+f9TzP8rL8mCK1xQaEdMFjK6lAo4EbaNeTiew==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6455.eurprd07.prod.outlook.com (2603:10a6:20b:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8; Thu, 4 Jul
 2024 15:12:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:12:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v2 2/3] intel_iommu: make types match
Thread-Topic: [PATCH  v2 2/3] intel_iommu: make types match
Thread-Index: AQHaziShhEkI93qTq02nWGGZ+3bagg==
Date: Thu, 4 Jul 2024 15:12:48 +0000
Message-ID: <20240704151220.1018104-3-clement.mathieu--drif@eviden.com>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6455:EE_
x-ms-office365-filtering-correlation-id: 8ba64991-c07e-48a4-a547-08dc9c3bc419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1BBU0I3NjRuZzVoRGk5blJwV1kxL1RCT1RXUHFPajF0ZVpXZEEyRWJWS1FK?=
 =?utf-8?B?em9UdjhOUXZWMGgyWTNXM3Rqb1hGY0VKM1hCV0ovSUQyWUxXeklUZVUrNmg2?=
 =?utf-8?B?UEYySzJrQXE2aXplaEVwUWlWeGc2SURPd0Jlb3hBY1RKay9QcUJIZDZERGgy?=
 =?utf-8?B?bFplb1l3M0dmUDVXRTcvcFk3ak1PWGxEWld2K1liRlJRVnJoVE9zajhlbkIw?=
 =?utf-8?B?aDJDWU42TGs4L3BOWjB4NzRXUU5OYnY0aE92NnZoZEl2aHBERkpFSEYxbFp5?=
 =?utf-8?B?dktZQkxtWFJMVUk1ZndxYWJhdmVKeng2VmJYekV2RENIbkg3WVUzV0E0OU0x?=
 =?utf-8?B?cHk5T3g4KzZ5RElldE4wbXpOUnp1WC9wSG8ydTViaEk3VS9HQUl2eTR0OFp4?=
 =?utf-8?B?NUQzQlI4TVhlZjlkVjNmajY0SlRYbjBzZmlkRkFxUWNqcFZQZk11WjFMSnUr?=
 =?utf-8?B?VzZGVFk0SUkrOXFoZzlseVZGREhUM2RHeENTZkZDdjIyZVF5VjZrLzl5dnl1?=
 =?utf-8?B?QzBBbWxtKzRNbmQ0WVZaY3Y5MWVDcHplTmQzd1pnYmlsRTgxMCtrSys4TThV?=
 =?utf-8?B?aEVKdGtlQUdIVjJHMDZrUTd2d0dzckZmSEdkdkMvMUpseGsvMDh6WDVneG5h?=
 =?utf-8?B?K29TMWJZc250NXJLb2s3V0FDdHFJUTJaeVBkYkRDS3I4R04vWHFwbCtnM2tk?=
 =?utf-8?B?M1EzYTlFVEV5VXhyRzVVU1NYYkJjL012NVZBSzhxRHI4ZW1lUDgwcTFRRkNh?=
 =?utf-8?B?VlJLcWZtUDFEelo3OXlXYzhSU2V1QlE3b1c2TDhtQk5Qb0JTNlBQRUV4ckQz?=
 =?utf-8?B?a0o4UmRwOVFPbHlUc0MzREQ2TGszRS9uemFkRS9pcnErQS8rTXdmOGZOTFd5?=
 =?utf-8?B?cDBNQzNGVEtuTXMyT3p1UGMxNVlRTHZWNC9ySnFNc3lVS2NrQ2lZQTBsTHJC?=
 =?utf-8?B?UlM1MlhHN1VZVmlTcG9LZlRrRTVhQ1NDOWVvRWxVeWJBNHlaeUgwZ0ErTU1J?=
 =?utf-8?B?VDVIaHRQdmlvVVZxRUtSWG1nYWUrengxMmJ0SnRoRGFVNUpOb29oa0t5c01r?=
 =?utf-8?B?Q1JjaFNWQ1BUSWFQVGFua24ycGhFbE5vSC9rK1cyRkV0REZvT1NUckV4cjJI?=
 =?utf-8?B?T3NSc0J1V0JvWGQ0WDhHOGJjSTQ0U3NIUDhncjRzYnE1Yk41MW9BdFBZK0Ry?=
 =?utf-8?B?aVErS2toTUNFSmNYZjhYR21MRG1QZUFjOWtnQkI3dEFjU2FKN1N2RVhkZE5U?=
 =?utf-8?B?cEFhL0hYUnBKeE9FMVNkb0hvUGR5T2lKNWlrelhEbjAwQ1Zka1Q4Y2dBZHYw?=
 =?utf-8?B?YWJ2UUJyK0U4UjRxeFJKV3BJZWo2UzNON0s2SW9KNVNmR1I5VE5Bb3d3L1Fx?=
 =?utf-8?B?MHNuNmZFSVA5QVhDWktvbHE5M2J3UEtqYzFjaVZpai9vKzgwUFhNQlZkMVZi?=
 =?utf-8?B?a2FpK2VVVTdJUzJiaVI1bWQveWV4SEMrMjc3UXdFc3BCSzFYQUtqNkd2ZCt2?=
 =?utf-8?B?bE90Sk9HaDBlSy92VWUvT3dVdi83OXp5OTBGbURDTHF0V2ozaWV4djdJTmt3?=
 =?utf-8?B?N0dVUkdOMFlUR0JMUTVjN1A3WTk4NDRRa0ptNHV4ZSsrbkdIaHlHVXRkRXJH?=
 =?utf-8?B?ZEh5Q0MxRmdnWVFNaW96V0ltVkdzREdUVFJBNTl4TUwwbUxrRUlqeWphNy9N?=
 =?utf-8?B?L0tBcDVLNVRXNnR3S3g3Y0tDZ1p6ZG54d1BsR2hoSGFpWDNHVFo3d3BQZW84?=
 =?utf-8?B?MjFIRXdFS3hZZXBvOE1IUEJkOVVpZ0M0N2RUS0FPYUFPN3FZbll0Tis0NWIr?=
 =?utf-8?B?WmFYTy8xNUU0YlQrOVhrZ0RsdnQ1ZFlINVRIeE5ZNUZKUW8vNlB1UzVPZzVp?=
 =?utf-8?B?d2F2TWNpZ2Vpc0FEVlBXK2Y1dlhGTndPSS9lTUVDUWp4eWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDlrd2ZaUUlqWi9yK0NBR0NUTysreEhZWlczZnBDZ1JyN21uSWp2NTNqNThN?=
 =?utf-8?B?OTBiNW1yMnFvaXczL09SdGdBaTFEVW5BT0NOY2pZeW9ST0MwcGV2VUYyVHBL?=
 =?utf-8?B?SWk1c1kzWWY1cU03R2ZJZXJvU1hUMExxSGQzZno3ZDNIbE9VWUVzeHlNbWdv?=
 =?utf-8?B?a0dMUHVVNW1wWk5JckhQaXNMWDROcy9uMytnYWY3a3IvOGF1Rm9VMC9ITVlZ?=
 =?utf-8?B?dS9sSUFubnpFU2FzaFk2dmxzb1FsM3pPWHo2Vmp6QVF6RWZUMTVpekhPSENT?=
 =?utf-8?B?N3kydGJ2NWl5dTZSRzdhVXR6a29Ua2Y0WHUrbXo4TEpPTVBPeGxYZ3FCdzVD?=
 =?utf-8?B?b1FBcjJWR1J0bXhjN25aZjVVWnAvY0NzOFVZQWNOdURPNzFRallwSksrQnp2?=
 =?utf-8?B?dnhwSUYrVnZlWjZNeC90UjlaTFU2MkFmV3lvRldxeThIMDhUYVJIcmQzYlhm?=
 =?utf-8?B?OE4rdzdtUWVPd1ZKb2VSejZGbERNYTdqQWhUZklZazkrMzJNMUZTMllQa011?=
 =?utf-8?B?MkxwL0ZFSWxuS2djUytQdWh5cDY1QXhCbEJtUnBxR1NCTkN3RGt2Y3krSnNr?=
 =?utf-8?B?eFRpVHFxZVNSY0QvdTRkS09LK1ZvQ0ppSDdKbThZb2FZYjdDcW5HYXlLRURR?=
 =?utf-8?B?Y3haTHJnNlhkdVpiYUY3SVYrM1l5QmFmZU4wSnBJZkxCWHZsSXVmOEc5eFFN?=
 =?utf-8?B?WjFMQy9NUHp4TFhlbm01WTVEMHlaR211Z080NjBNUzA3UDkrc2JnU1VvT29B?=
 =?utf-8?B?RnRTRUFEOTIzaXM3RXU1VkVhaisvWEdBYzMxYkdTYy92YkRsVUFxYW9vSGo1?=
 =?utf-8?B?aWtPYmswSHVObXE0RTY0QVRTNFhKcU8yK3ZpMXRlcnJxdW1peHdsL3pHRmFF?=
 =?utf-8?B?aURLOVBwTDNGNWs2SW92UGUxNjZNbWxCQWRKS29WWWlNS1FtTENCT1VDSm1W?=
 =?utf-8?B?MUlNSk9HeXNMZmNjNy9Wd3B0RUxDbjNOOEkxdkYvS0RGbDl2OEdCbDZiemZD?=
 =?utf-8?B?blJwN1NBaGF6emVybFIrWllmbEoxVkUvSnQ3ekpMd3ZETVFGV0NDaExmczlH?=
 =?utf-8?B?UHNXb1dzSTBlUk1UcDNuczN5amo2NjVsVEErSzJjOGE2Z1RJbXo1dTZjbDRx?=
 =?utf-8?B?eUNmYytHK3RKMlh1UEZIUFEyTE9zWjdXdW8vangzOVU4YXNYcFhBQy9qMkpD?=
 =?utf-8?B?dmRHdm1qREYvNzZobVFRNnJKZGtvbHdnQy9pQk9EUlRGWlBkRGhTS2xKbVJN?=
 =?utf-8?B?WHNHZTBxZUlLL2dZcUpMb245aWNWUkJKM1ZMZFhXWlhjWWd6ektDR0JKdyto?=
 =?utf-8?B?UXBHcWptR2I4R0hqK1VEQXR2VGIvU0pmdWhaaFZUN2p0U0tDNEx4eFNqdEZq?=
 =?utf-8?B?OW5tSEE0YUdOTHhUUVZNL3o5M2RndnNqbU5jd044VVpybkF3YkNDY1prdytV?=
 =?utf-8?B?S254VFpYUTdkWkNhbG5XanQyUUtob2lmVTJFTHJYbTZGeEUrVnU3TjJsRlJY?=
 =?utf-8?B?dXlGWTlyQkMxdVZRQUUxamRuV0Jzd3o2cEVMVGlRNHRaVVdmM0RZb2d3T0Fj?=
 =?utf-8?B?MUVRZVZVbThmcFBUY3c3V2F1Tk0zL200QXBzM1F6YXM0RW5jUWg2VkFwYWRx?=
 =?utf-8?B?TEh2Z1E0dXY0cC9OVDFFZVVDc3pyUWdzeGQvaFRNNmppVmdLZVR2M2owbFNY?=
 =?utf-8?B?Rm5GUk1SYm9aQnVhbCszZDF5d3JmQU4zNGQ3VkU2TFE5R0FBUlc0Zk9CWXRy?=
 =?utf-8?B?dThTdjNNNnJPeUlxd09meUhYd2R3dEVoSENBdkJqbXdaWTVMZ0FiY3ZUTTVu?=
 =?utf-8?B?dkdZZE8vOGlGd2gzb1p6TUJkaFNIa1c1c2pFSVFiVWhlNFY1K1puSUR1RnA1?=
 =?utf-8?B?WE80Vml5ZTR0bFpaZVhVRSs5bHVyNkdwQlhzb1ZYTkQxR0JBR1p2WGxhSVNz?=
 =?utf-8?B?QytIRDEwcWVkM3kvMXdWb1lLU21rSVRTQjJ2NjR3ZGJEcnE5U2VTazBGNFFl?=
 =?utf-8?B?S0EyQ3IzUzVpVEpnWTFiOHljVjEvdGIyaTB2a3dXLzFEWDVsbnY3UzJrWmFF?=
 =?utf-8?B?STNZd3N0bDN2cG5xdi9sUXJaajhaK3J2eDBvRk5abVhMcThFc0gvZ1ZsN1RL?=
 =?utf-8?B?KzRobEZlczRnS1VEb1NoMDZoUTNTbk1kRmQ3N210WDBZc3pjclJSQmpQeC9K?=
 =?utf-8?Q?PW6lpSlY8Awx+VvTkQ3Bdo8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82FB477312FDD042B15B559A837FA5F4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba64991-c07e-48a4-a547-08dc9c3bc419
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 15:12:48.6189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfWnISGlKNQo5unx69g4eLSzuNhGzwm3jdYsCVEBN7EMQCMDWJ2gcZna2tI2EBwtEw6Re1YPWpDrvJeTxHmSRAR687tzzuFl+A82v5AdLMf3xILqUiccUmOJCrWzukKt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6455
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClZURElPVExCUGFnZUludkluZm8ubWFzayBpcyB1c2VkIGluIGJp
bmFyeSBvcGVyYXRpb25zIHdpdGggYWRkcmVzc2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVu
dCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0K
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIgKy0NCiBody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggfCAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDM3YzIxYTBhZWMuLmJlMGNiMzliNWMgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KQEAgLTM1OCw3ICszNTgsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeSAqdnRkX2xvb2t1cF9p
b3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCiB7DQogICAgIHN0
cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7DQotICAg
IGludCBsZXZlbDsNCisgICAgdW5zaWduZWQgbGV2ZWw7DQogDQogICAgIGZvciAobGV2ZWwgPSBW
VERfU0xfUFRfTEVWRUw7IGxldmVsIDwgVlREX1NMX1BNTDRfTEVWRUw7IGxldmVsKyspIHsNCiAg
ICAgICAgIGtleS5nZm4gPSB2dGRfZ2V0X2lvdGxiX2dmbihhZGRyLCBsZXZlbCk7DQpkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQppbmRleCBjYmM0MDMwMDMxLi41ZmNiZTI3NDRmIDEwMDY0NA0KLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCkBAIC00MzYsNyArNDM2LDcgQEAgc3RydWN0IFZURElPVExCUGFnZUludklu
Zm8gew0KICAgICB1aW50MTZfdCBkb21haW5faWQ7DQogICAgIHVpbnQzMl90IHBhc2lkOw0KICAg
ICB1aW50NjRfdCBhZGRyOw0KLSAgICB1aW50OF90IG1hc2s7DQorICAgIHVpbnQ2NF90IG1hc2s7
DQogfTsNCiB0eXBlZGVmIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIFZURElPVExCUGFnZUlu
dkluZm87DQogDQotLSANCjIuNDUuMg0K

