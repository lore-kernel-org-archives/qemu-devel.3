Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C61CC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jl-0006nk-WD; Mon, 03 Jun 2024 02:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-0006gx-R2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jc-000731-Ov
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394397; x=1748930397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hK7styFD7PCpSuTqw2+IHY/14iimk7sPF6ZR7mmO87Q=;
 b=dOIZIS5kTGzNLRllhHlXdvajTliOng8eDYPZvpmhUAumRNhJZfwnXkW1
 BK0uhcpQIBmaGXlIgCl0NqiT147JPhPpbkKmcuMzvFB+908Q5fynScmeC
 agUyS8Et8/njHSKAOFDxi8O1FFTrcdty9WaTrC2zyEwjBzA9Gh8Q0hXi5
 dzFV+pApBDut3G4K5hANtnZSt41PY74gsgr2HxVmHVX6qZdd3N+oSohSY
 9rqzmNtKbIZ7WRVZsuKVsMtoGYHepEkjJ8vqGMn6jK2h6f5NlH6F5VRcS
 w6Gx+AMd5GCxueJkxbNxGgUSJGBnFUbW/s9XDeVkZbHvj73KWEV4a54BP g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13763248"
X-MGA-submission: =?us-ascii?q?MDHZAAo1OJOV+Fyug36ems18i4MkrNmeAB7tbq?=
 =?us-ascii?q?gwyCWfnLzNqzmMk1kQbgOMby6oYv/NunlRqpr5LAw18pC+lanF+biuFY?=
 =?us-ascii?q?ha7ho4mQUh1L9jdRQcVfvUb0/JxFBogU854jiv7tn6Te0n4hPedCIZI3?=
 =?us-ascii?q?K9q8ZIb2wZMC+w5NfQq2x7TA=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf8DfcDxL9a3rhILDOvWp9Mj5ABtwXZo+apzN+9zUem/xsXAMa9YKgvwhI5CyWNrLwwWqfLR/1WgtIHF98c6fhWCwY+GZwnsMUue+GiWa9itfyVubpG6FkBngWjzlrXOtz52lwGDztr7zU9bf9Ig9SMatC75L0+/yZ/moNZ4wXNcgBhqRGkzNDHdyc9Ot3pU8Myn6lyfMep1qojDLMpVBOJB1JDXnlnl7vL9VIbhdcMDqB0anmrC3BTYWFWOehEaVSJir030GQZjmmPdhbt6PKzb740XL4CkkEP4BOOkD+fO1Gmypy8gY+ow0AKYVluaxTOToUgfoM9De0k36jtA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK7styFD7PCpSuTqw2+IHY/14iimk7sPF6ZR7mmO87Q=;
 b=dPNjoMUR7C93kgROOsPpfFz2oOf4i5ePQ21PjATpcHrfEfxUTdoZ54enYe56H4LBoOH4VuBe6q8W9l1UrbgS31HO7THPBDQafbTTMPbyo2c4bXDU4bvUiARMaO2zKXUNVsv8a7WgfBzseBronB7bXeseKS6uLdlkBKZx6x+7O4EP8LmS++9cmtfHH9yV7OWSaKwgbpUFNXNwzOoqnMgzHWy5bBXMKqIswXt17vm5PDjE/0txaJVdPJGhIJde8VwZioinJ4UZXbdj4WLFA1qki7eiHOr9PscuKcjr/1oVRYbzzUKfD1BrynWs5IB7RZKxddzifRbgOhDk2duBLAD6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK7styFD7PCpSuTqw2+IHY/14iimk7sPF6ZR7mmO87Q=;
 b=TGFxeGK/TNshkWUxHgW0ClDD7vIW3WmEWU236nFJabuwwn8HHU01gesKehq6YblpHNKdj6hKWDql/WuBRcW/x3uJXuD4TfTZUa8vMWDaaL+XuRGloUjSInF7f6inZ8H5v+v3gYVGFj2bj96N/YfjGeUytVIwGfiZypYrXI5ALKQrdunpIGHstpOfjBxH+ZB/gEqjjFd5zCz9fhmIfW8Y/XFzXfMpfZKWMSvDb2hSodCFpV+f5ScsNvUqoICy7em7e3stl8cM5AVOQEyX/J43RoaxdEY0Lh8jpLOSxaQwE+Hq6MTgDRzHKuf5Y9PUCfiBxyBxtvS4AJWVE6CFzzB+2w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 09/22] pci: cache the bus mastering status in the
 device
Thread-Topic: [PATCH ats_vtd v5 09/22] pci: cache the bus mastering status in
 the device
Thread-Index: AQHatXs8uu4aQUIynkS7hn2PtCehRw==
Date: Mon, 3 Jun 2024 05:59:46 +0000
Message-ID: <20240603055917.18735-10-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 753f9ba4-419f-404d-c104-08dc83925f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a1dyT01zaVpHdFp6dDdoRmJ2R0Z2eTNHUkZPL01KV0F2cDNJaElmdWJxUWJC?=
 =?utf-8?B?dkc4WDNlZUI0VE81YVRUbUFOMUNzSE5IVG14K3RiNFBGRnNrbk5nN3BFbmtC?=
 =?utf-8?B?Q0Qxd0Z1VGNMdjh0cXNjTE1KbW5ZaDcvc1FsWnZWQzAvZkl0clVQUzlMbzNE?=
 =?utf-8?B?TlkwMUtTRXYvbmh6QkpDUjJxaGFUMVdFb2lTTWYwUlZYUUtQQWhhUVNIY25n?=
 =?utf-8?B?c2lJWU80ZHc1cThGdE9aamxRQ0hjTVZDZU05UDVvZXlSZGNDN0poVHJsR1Rw?=
 =?utf-8?B?MWx5bjhvdklYVHRoSzFWNHJiSUFBSENCaVNkQnNub205UWxRb0lJUGZGajNr?=
 =?utf-8?B?VUpReDE3YjY2OFdZMlR6VDlDNWJJazRjdDhBZmRrdEFIREl3eE9VUEJIQnl1?=
 =?utf-8?B?Tm1xNUoxR3JOTWlIVWYzWnFhOHN3THIzbnNrR3dEK3JQZGdqZVVGanRQbmlV?=
 =?utf-8?B?WUdaN3djNVpvT0tCZy9TUmFJTDJVdStreWl4LzVXbWNCck1XTnV3T3E4alhJ?=
 =?utf-8?B?N3NzaDdYbHUrSXRaVWRZN0hjODBNMDBUL2hDaGNFb0VFYU5GNG5MMDU4RHFQ?=
 =?utf-8?B?cGhwUXlwOEhQbDZCRGpTOHpUQlVHMStFbkEyRFoyTnRZdVVBZStMeG80b2li?=
 =?utf-8?B?TThUMmxWcmc3QXZqRVRheVdsV1hNNFJyWExibkRVdWxudVBtVjNGZHk5MEZt?=
 =?utf-8?B?clZucmQrbUxqNEU4K21zdUUxajhudlFIdjc1aFI2UHZXbC80amdRWjRzM3Bu?=
 =?utf-8?B?ZXpFNkpiY3JINEhRT2RQcWltakN6dzFVR3d4VXJkb2hIOFdnUXFWNUZnTVp5?=
 =?utf-8?B?dFdMVWpWNGJSeVQ5ak12aXVPS3U2dmdMWVZGRHVXcnhIakhMQjlaWVBxa1cx?=
 =?utf-8?B?YlE5ZXNCemt0Qk5PV3V5Y2ErNHNZQ0JDMGpNOXZkcmh1RXFTdGVHL3RCV0Nl?=
 =?utf-8?B?bTZxN056YytHYXkwSDVjL202QnBsY3V5bkFOaTBGYXJnOG9BWWlETEVOT3gr?=
 =?utf-8?B?aFUzd1VuRWJjT1ZlVE1LUkhseTdlOWU0VktaKzRncytVVzNSUUsyWEpMNWU0?=
 =?utf-8?B?RC9uVDlqSUN3NjEzS1RZZFFuMmU0Z2VCZE1XRU80UjlJYU5neVo2QUlkSGpD?=
 =?utf-8?B?VVpNM1JBL1R3MzdTU05obEpHeVhEa2dlNkZBZDZxVEo0VlQ0YURuR3FsM1lk?=
 =?utf-8?B?UnIvOUZOWjFGaG9ONWlKUXZFZ1JtQlh1NWk5N1dyMUtZQkhZVU1ZNVNRRWpz?=
 =?utf-8?B?My9UN1B6bmdsSGh6Z2xUMFhHZFJmK1BpMVQ0RHEwdVdxdHJVTU9SM3JVYTZ6?=
 =?utf-8?B?eEVINVVCNlByOGZYak1WamUwVmxDUFE3Nllxay9BdVhISlBTV3Y0MjJ3U1Q0?=
 =?utf-8?B?dFI2cDUydy9UTW9rNVpnQWl3U0IzT1l2bTZhdkQ1RE1pTDdnRyswQloxaFlv?=
 =?utf-8?B?UTBPdXRHL2xSUVJwamIybE9Memh0TmZlS1lTeWNIRzJGQ1k0ZjVRNnR2REx6?=
 =?utf-8?B?NmpJamVOT1VWYm1DM3VGWE56bnJCSnlZRVJOa2RCRHo1QjlaUjl1em5SdHVW?=
 =?utf-8?B?Nklha2hZL284L3JFRWowbXlDdHBtWGxtRzE2Zy9kcEFZN1N6eDZrb0dyaDlX?=
 =?utf-8?B?aGpBNk9FY0dodXBEdzQyN1JFWXNyNjNLaVo2K1IxQzZMblI3dHNzYzZLbTY0?=
 =?utf-8?B?WUczMUhnNGd6SjdrUUpGVnAzK1ZackFZRXJSNlRsWDZCTUZuK1d1L2kyVlBH?=
 =?utf-8?B?ZURXS1hERkN1d1lRSGlZcnYxRW5FeXc0d3ExSHBVSURPNlVtWTltUjZ6cTEv?=
 =?utf-8?B?blFuL1l4SHF2Tk5NeFZDdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2w4R2JWTkZQQ2F5M29NNjdiK1JZQ3l3VWJJWlQzM3B0enUzZ3hOVUdhcEYw?=
 =?utf-8?B?UURDcFArWWJhVE9IQXI1Qm84WDFLOUdhcFN4eTcrV1BxVnJSaWVtQjdGN2gw?=
 =?utf-8?B?MjE5OGUrY1ZVT05FaWU3eXNuU1kzM3FndlJhQVE0aGxuclAxaVAzN3hWZGlr?=
 =?utf-8?B?dGdlWHVYdGdVNnAwMFdUMDRHMkFrSjR6c2s4T2pjL25pdGxmM1AzazRENWpX?=
 =?utf-8?B?cDJBZk1Ic3ljaC9mMjR5eWlFdE15ajdIVXByN2JlZzBkeWxtMVVOSU1DNnlv?=
 =?utf-8?B?ZnlYZEhmdU1zdTRDVTBCTDEyL2lpRFpTNGMzL0tKbXJJY01jd3Z5TFNGeUxn?=
 =?utf-8?B?ZlErOUdqNXZJM3RaU1ZQT2JzdWxYenozY1RzTkhGZFZDQkNUL1BYTnlBQVl0?=
 =?utf-8?B?TUJERVo2MnhJMEdwZjNENXlGZVUvZ0svZXg5b3lYd0V6NGtCMXFXVkhva1FO?=
 =?utf-8?B?dTlwRTdleHc2TDUyWGJVS1BybkppSTF2K3QyTE1jWVNKL1B3Q3krbTJjN1Ew?=
 =?utf-8?B?MkRSVlNTMUJ0YUhTdWV4WXFiajF5aGlXUmw2MGwyTS96aUJ5NnJSL3BxK2Vm?=
 =?utf-8?B?cVo0WlJqTmNPY0U2ejhsTGVZd3RLS1ZnaEtLY3FvNWFFZzZtUDlVVWhjNXVZ?=
 =?utf-8?B?L01DNVZNQTFPM21GN3RpMEFLdW5vSWJlT3I4alAzVkE4Rmd0WXRDcWVFZ1hN?=
 =?utf-8?B?NVNhdWZUTThzaTRrZjVQcThlVndxWVFmeGhRS04wOXZrNnIrWEhpVDV1NXA1?=
 =?utf-8?B?SUx2alEyZVNVSjJ2M2RXU0FKbDQvdk5yVnkrZXBTeXplaStmc3Q1TDh3Q3lS?=
 =?utf-8?B?OStMdHEyc2poUWVUK2NJQjJBYjFmVWhmQWUxbWFFYWJMcE1rOEJMWDJKaERK?=
 =?utf-8?B?elFvK3psTGd5eGtieUxyWi85L3BkUVQ1R3VJeTVtMkRjdDJ0K2M2dGFhTkJD?=
 =?utf-8?B?c1phWjBQQ1RIcW1XRlFWelZZb2ZUd0p6aVh1ajBvdEZzc2FEWGdYNlBUK0ZY?=
 =?utf-8?B?RWs4dVk3dUVBVnY5VEY2dEdMRU9BUWplaVBGRk9rVk9GcU5lMGFyR3JkWFBr?=
 =?utf-8?B?R0VMMHhaRTdkTEEzcHovQWRNM0tnWkJaWGJGaXZmbWNvWjZ6bzNkQlVyQUFw?=
 =?utf-8?B?UjMySkRsQ1BvWkhnbmtvWGRPL2x3UmJacitSYlI1M0xqcDRSbVZzK2hsVjM1?=
 =?utf-8?B?QWtMRlJJVlE3WFFreXJ6Qy9HekhBakNjVmMvMmpFZ0JzQ29GS3BhVE12dFR6?=
 =?utf-8?B?Q3E1WEVwbG1LWHdJUEZqZzBROEFrNmpCQWREcjdFZzdOcndTam5TU2tWWUtO?=
 =?utf-8?B?Nkx3WjYxblM1TU5qSDVzYnR4MktkOEZzRFFKSjlZT1ROV29jVGRxSnBmQ0dv?=
 =?utf-8?B?YXFKeVV3VHUxalp0dDdKNVN2d3k0cmZhTXV3Q1JKaUszUkxKeHBkY0RxSzJm?=
 =?utf-8?B?TVVPbkhkQ2dZb3JBaCszTGI0NGxaTXpzT1hYN3I2ZEp6VWo2OVhKSzdDZnRp?=
 =?utf-8?B?V1JSM1lxYlVxam5adUZMSGNwNDFITkVvRm92enNacGhzMXlyTEliUVpJbnR6?=
 =?utf-8?B?OGdpcjV2LzU0NTdPWnpWMUNodzlCRzBrbEhvaWE0OTdZaytRRk0xTEU0eHJY?=
 =?utf-8?B?SWloQTBLZEw1VERiZlFhNGRHbkFnNFhldXJoOE5sWXhOZ1Y3aTBaNDJEamRO?=
 =?utf-8?B?Y29paXh0bkh1OFV4NjFPUVIybEM1Vm1iYk1JTnZzRG5FY3JiaE9tOU4zbUVO?=
 =?utf-8?B?QTBuRElyRU5lSk9IME9YYk83UjdkRFpORnJIM0VWanBxbXR0V3diaDBhaEVI?=
 =?utf-8?B?WXRVK3BUQy9vOUZIOHpXZUpyTWUyUDQ3MlhaczFEbmtST0ltYUFjSHo0dm9z?=
 =?utf-8?B?U0IyS0kxZlBSdTRDdTZWbUF0bW94TUNxd3pBUHBJdTVPMDdNNTR6RCtZM0M4?=
 =?utf-8?B?c0ZNNmhPcHlveSs0TkFuU2thWjh1UzJxSTBIVHBUQzFXRG5nMmdkOHh5ajJY?=
 =?utf-8?B?dFg4YkIzMUZ2aW5UTy9pKzk1MWNGOURlQ0FVSi9JaFlxRENBbFVDSlEvWS9n?=
 =?utf-8?B?Q0JhWkhtREZCMjNDaWVqQTF5SG0vNDlDSDVMOWdtUGJQT0trTFJiN2tKaHBr?=
 =?utf-8?B?UFhSZFpTL1JFSWQrSWtnUENlYndSTFB0Y2h2a01mRGN5NmxvQnlaZ29ienZK?=
 =?utf-8?Q?zXDOGODgzUgJarng+cfk2Y8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0330FBE49A40324C94D980484758CC6F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753f9ba4-419f-404d-c104-08dc83925f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:46.5829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2itEcEgfnG1v3AXPuYUhWBqBPtGIjUCpg4LB4WRs4iiMqBaGzPFpUXBZzD52DQSJExhxLNJEfhpaJmwYa4KaiXo9oaMqP8z0wrC2nw4M87f13fp3n0qBSVLhIg2+DKJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgICAg
ICAgIHwgMjQgKysrKysrKysrKysrKystLS0tLS0tLS0tDQogaW5jbHVkZS9ody9wY2kvcGNpX2Rl
dmljZS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmlu
ZGV4IGM4YThhYWIzMDYuLjUxZmVlZGUzY2YgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisr
KyBiL2h3L3BjaS9wY2kuYw0KQEAgLTExNiw2ICsxMTYsMTIgQEAgc3RhdGljIEdTZXF1ZW5jZSAq
cGNpX2FjcGlfaW5kZXhfbGlzdCh2b2lkKQ0KICAgICByZXR1cm4gdXNlZF9hY3BpX2luZGV4X2xp
c3Q7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHBjaV9zZXRfbWFzdGVyKFBDSURldmljZSAqZCwgYm9v
bCBlbmFibGUpDQorew0KKyAgICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVkKCZkLT5idXNfbWFz
dGVyX2VuYWJsZV9yZWdpb24sIGVuYWJsZSk7DQorICAgIGQtPmlzX21hc3RlciA9IGVuYWJsZTsg
LyogY2FjaGUgdGhlIHN0YXR1cyAqLw0KK30NCisNCiBzdGF0aWMgdm9pZCBwY2lfaW5pdF9idXNf
bWFzdGVyKFBDSURldmljZSAqcGNpX2RldikNCiB7DQogICAgIEFkZHJlc3NTcGFjZSAqZG1hX2Fz
ID0gcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKHBjaV9kZXYpOw0KQEAgLTEyMyw3ICsx
MjksNyBAQCBzdGF0aWMgdm9pZCBwY2lfaW5pdF9idXNfbWFzdGVyKFBDSURldmljZSAqcGNpX2Rl
dikNCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2FsaWFzKCZwY2lfZGV2LT5idXNfbWFzdGVyX2Vu
YWJsZV9yZWdpb24sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QocGNpX2Rl
diksICJidXMgbWFzdGVyIiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hcy0+
cm9vdCwgMCwgbWVtb3J5X3JlZ2lvbl9zaXplKGRtYV9hcy0+cm9vdCkpOw0KLSAgICBtZW1vcnlf
cmVnaW9uX3NldF9lbmFibGVkKCZwY2lfZGV2LT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sIGZh
bHNlKTsNCisgICAgcGNpX3NldF9tYXN0ZXIocGNpX2RldiwgZmFsc2UpOw0KICAgICBtZW1vcnlf
cmVnaW9uX2FkZF9zdWJyZWdpb24oJnBjaV9kZXYtPmJ1c19tYXN0ZXJfY29udGFpbmVyX3JlZ2lv
biwgMCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwY2lfZGV2LT5idXNfbWFz
dGVyX2VuYWJsZV9yZWdpb24pOw0KIH0NCkBAIC02NTcsOSArNjYzLDggQEAgc3RhdGljIGludCBn
ZXRfcGNpX2NvbmZpZ19kZXZpY2UoUUVNVUZpbGUgKmYsIHZvaWQgKnB2LCBzaXplX3Qgc2l6ZSwN
CiAgICAgICAgIHBjaV9icmlkZ2VfdXBkYXRlX21hcHBpbmdzKFBDSV9CUklER0UocykpOw0KICAg
ICB9DQogDQotICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQoJnMtPmJ1c19tYXN0ZXJfZW5h
YmxlX3JlZ2lvbiwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY2lfZ2V0X3dvcmQo
cy0+Y29uZmlnICsgUENJX0NPTU1BTkQpDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JiBQQ0lfQ09NTUFORF9NQVNURVIpOw0KKyAgICBwY2lfc2V0X21hc3RlcihzLA0KKyAgICAgICAg
ICAgICAgICAgICBwY2lfZ2V0X3dvcmQocy0+Y29uZmlnICsgUENJX0NPTU1BTkQpICYgUENJX0NP
TU1BTkRfTUFTVEVSKTsNCiANCiAgICAgZ19mcmVlKGNvbmZpZyk7DQogICAgIHJldHVybiAwOw0K
QEAgLTE2MTEsOSArMTYxNiw5IEBAIHZvaWQgcGNpX2RlZmF1bHRfd3JpdGVfY29uZmlnKFBDSURl
dmljZSAqZCwgdWludDMyX3QgYWRkciwgdWludDMyX3QgdmFsX2luLCBpbnQNCiANCiAgICAgaWYg
KHJhbmdlc19vdmVybGFwKGFkZHIsIGwsIFBDSV9DT01NQU5ELCAyKSkgew0KICAgICAgICAgcGNp
X3VwZGF0ZV9pcnFfZGlzYWJsZWQoZCwgd2FzX2lycV9kaXNhYmxlZCk7DQotICAgICAgICBtZW1v
cnlfcmVnaW9uX3NldF9lbmFibGVkKCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sDQotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsg
UENJX0NPTU1BTkQpDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9D
T01NQU5EX01BU1RFUikgJiYgZC0+aGFzX3Bvd2VyKTsNCisgICAgICAgIHBjaV9zZXRfbWFzdGVy
KGQsDQorICAgICAgICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJ
X0NPTU1BTkQpICYNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0NPTU1BTkRfTUFT
VEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KICAgICB9DQogDQogICAgIG1zaV93cml0ZV9jb25maWco
ZCwgYWRkciwgdmFsX2luLCBsKTsNCkBAIC0yODg4LDkgKzI4OTMsOCBAQCB2b2lkIHBjaV9zZXRf
cG93ZXIoUENJRGV2aWNlICpkLCBib29sIHN0YXRlKQ0KIA0KICAgICBkLT5oYXNfcG93ZXIgPSBz
dGF0ZTsNCiAgICAgcGNpX3VwZGF0ZV9tYXBwaW5ncyhkKTsNCi0gICAgbWVtb3J5X3JlZ2lvbl9z
ZXRfZW5hYmxlZCgmZC0+YnVzX21hc3Rlcl9lbmFibGVfcmVnaW9uLA0KLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJX0NPTU1BTkQpDQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1BTkRfTUFTVEVSKSAmJiBk
LT5oYXNfcG93ZXIpOw0KKyAgICBwY2lfc2V0X21hc3RlcihkLCAocGNpX2dldF93b3JkKGQtPmNv
bmZpZyArIFBDSV9DT01NQU5EKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1B
TkRfTUFTVEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KICAgICBpZiAoIWQtPmhhc19wb3dlcikgew0K
ICAgICAgICAgcGNpX2RldmljZV9yZXNldChkKTsNCiAgICAgfQ0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaA0KaW5k
ZXggZDNkZDBmNjRiMi4uN2ZhNTAxNTY5YSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3Bj
aV9kZXZpY2UuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oDQpAQCAtODcsNiAr
ODcsNyBAQCBzdHJ1Y3QgUENJRGV2aWNlIHsNCiAgICAgY2hhciBuYW1lWzY0XTsNCiAgICAgUENJ
SU9SZWdpb24gaW9fcmVnaW9uc1tQQ0lfTlVNX1JFR0lPTlNdOw0KICAgICBBZGRyZXNzU3BhY2Ug
YnVzX21hc3Rlcl9hczsNCisgICAgYm9vbCBpc19tYXN0ZXI7DQogICAgIE1lbW9yeVJlZ2lvbiBi
dXNfbWFzdGVyX2NvbnRhaW5lcl9yZWdpb247DQogICAgIE1lbW9yeVJlZ2lvbiBidXNfbWFzdGVy
X2VuYWJsZV9yZWdpb247DQogDQotLSANCjIuNDUuMQ0K

