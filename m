Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA93C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lQP-0005A9-4P; Tue, 14 May 2024 02:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s6lQN-00059Y-C7
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:14:07 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s6lQL-00029L-1P
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715667245; x=1747203245;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=soe8I+Fpiy1bRvAgJVsfAbt8MPUgAtzzbb/I0HoqoIo=;
 b=JEY43e9j8leCzYAVLyX9eT1gwZ0DGSvlV5yy2kbe/Zldb2uzSTegLUoc
 TsVg0jAY2guh8IKhVlWQnqXZOqxdGOypcVnm/ehaOpXkwg3DZ8Zy+AWtI
 WryukzsmT+MhBAuahX9XwrQDJIZlOSKMpjs+FeaNk4h+bs14JNJbDbCqF
 Os/sNtpUTO5x8goz7UmAISM1Lud7C244kR2VbgbsP/l2aQlEjJEAhp0Dh
 v9xyW4MKVGDF+0CwqkTdgs/wdzRarCZJKghdZwlbbSREYG3fyjhewTUgs
 ojOjJHIsiZHLW1YQ0iU0ya+806cPGk7KL+UWVvadT1esrGnZwtJdtIuiG A==;
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; d="scan'208";a="12488983"
X-MGA-submission: =?us-ascii?q?MDFYTFW2wi8pjHZ65j3j0W8fonCZOwxZH8WfDj?=
 =?us-ascii?q?SmEhi3O/LL1Af2RebtrAwPyaWVf7weThWzPiRlrCJsXVR2fjUpWx7eOV?=
 =?us-ascii?q?RIkeOfSxyJlQiWsOhIxLcOhJX2N5HjAugt5UcQa7szeLjq+W21GALe3s?=
 =?us-ascii?q?pWilNF0uzu+rhx2k1bDqzuaw=3D=3D?=
Received: from mail-db3eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 08:14:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Cb9qUCIpPyLCDproWXGN8NXBg3UtPLGL3pmHJMYIdwFXb9EtlMLx/PbDfnlp0YUGHR9RssriQBs/t9tIixjaFo1pu0GBGujCxE4YqjkkjV/akzMyZUFlP6OpFLafel+nvOA+NOCZvytGhMYIdlWlwOIOYNkxZcGWgT9M+pX+T+BrS/bFbOk4xGURPIGHZ/BG/oc6wtGEKwRYdOZz3PKFz1Kc7bcPDcL37xMyjGvZA+2Ai3lJ+0hj6oPKR7qkW6DK9rReuk0MHP9zxhEDFVHLjWFkaNn8Llu6YI/foubbSW/621fwU55v74/aBdKbXYgangQeDyPSWySwijrrfHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soe8I+Fpiy1bRvAgJVsfAbt8MPUgAtzzbb/I0HoqoIo=;
 b=QxiAP+POYvX7nmD/81xqC15DCK3Ry/S8ZZBCDMzdml79bZipXqOz5REjPcZqFJcZ/l2bDXXFnCXHCXkrXLS9Y2wSK938ono+UfKgOBYo3TWjHIY3t0FH7dTg+1KkYbHVjOVUHKeqpGXOvKAUuUjpkDE+nN/+IynFsMmaqSDQZYHSEQx4CRe91OD/ImlU4XkhEnSPEjCPmIU0XOjRgzgRpT6+1tYFuMEOK/xtw+WsDKZNIrbkPOYUklxtOAKQiMYO6kAsOhuDwATiCKwavjoqc5v/niCBT2gadPXIiqf15gAhShKBD/n/hOyEyT8lQOkOXHOxVcE0TppEndDHnwDIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8788.eurprd07.prod.outlook.com (2603:10a6:10:310::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:13:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:13:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHalM0ix1VtZwm0bkmmtp6S6avLxLGA52yAgAF4ZgCAARK/gIAGD/KAgAzLsoCAAA1/gIAABnUA
Date: Tue, 14 May 2024 06:13:58 +0000
Message-ID: <af2ec9c9-c414-4e22-9e14-75241671c2a4@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
 <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f00d7bfa-91d0-4c58-8b7e-bd3dad477e9f@eviden.com>
 <SJ0PR11MB67443F458DB55397FA4BF58C921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d150cb99-4575-40f2-a3bd-f4143afaa14b@eviden.com>
 <SJ0PR11MB67442E0DD7D336E2BC26A90F92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67442E0DD7D336E2BC26A90F92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8788:EE_
x-ms-office365-filtering-correlation-id: 2bb14884-3d39-40e1-6a22-08dc73dd0ade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|7416005|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Q1ppczdRdDdseHRVdk5rOFZkWk95b0FpMmV0bXN6bXhyNGNFNVZmY3hxNXp3?=
 =?utf-8?B?OVQrekc2Z2FhWXFIajZPRkxZaDA1bXRsNU9LdktUSXR0UHN1UlpiUEloWGJo?=
 =?utf-8?B?V2dOZ01ZcHE3WTBOUXBzMkUyUnFhWFZCWlh0Nks1RUJJWm5sZWFKVVNGWC9k?=
 =?utf-8?B?TFMwNW9wZmVsc01YQllyQXFsR3JWZHFnTW4ybEtYZGpSa3FQQlFUV2hFS1Jl?=
 =?utf-8?B?SnJqc3RKNm52MXBHWi9FVm9YYWIzMGZXb2dsNS85N3BhY1RsTUxoV2M3cCts?=
 =?utf-8?B?MU9ZNkxWNHJNZlgwZWhVamdxVG12U1hUZnNYeXRQTXcwWk41NjZEZkg1dkJj?=
 =?utf-8?B?WFFjWWFUekx1Qkl1QkdTTXRIdHhrMUMwSm00UmV1YVlNQVF1NVY1RzlFU0lE?=
 =?utf-8?B?V2IrMjg1Y2JpU2lFVHE1L2dTYUhFSFlWYndYUWJJMytnb2lWS3N5KzN0RE5Q?=
 =?utf-8?B?OWhPY2k0dlZpWUpFNlJiNjZsSVY2ZFd0ZlA0RFlCTzk4NVRxb29ZTERHZFp0?=
 =?utf-8?B?N3N0QU9oQmJDdXNXM2N3aWx6T0JxdzFMWmlEZ0tkRjlBUHZrRXppL0NTVnZi?=
 =?utf-8?B?cDZzK0JWV3VqZEZMa3lrdTRSU0I4dDR1MlNnNVlNanZsckVreVdWNWthbktK?=
 =?utf-8?B?MlNCbnF3VEZkSnV2VHZRVlFxTjdZeWJNUDZRU0dYVE9wSVg3T0t1eUhHYysw?=
 =?utf-8?B?M3VXdjRnZHN4SnFYellpRUhDamd2ZkQydXpnRjZuSnJLK0E4eDF0aGdYa1hF?=
 =?utf-8?B?SDh5OVhkOXlWRGNrNkRkWHR2SmNyRVEwZTYvWHg2cEgySmM4a3lLeUxrNUFH?=
 =?utf-8?B?UjArM3VhZTkrMGhib09tY0F6UjVkRUdVY0lxRy9EYStHUktESXY0ZVRjdkhF?=
 =?utf-8?B?Mnk5ZEhHM1RXYzJObXBBSUh6YkR2am1aOHpnQXVPdlZIVHViZitRUFFkTXlo?=
 =?utf-8?B?dWliNE93TTlhbHVNd1FUYm92Z0p1V1UrVmxuOGx4bG1hWE9FRFZBTXNJUWt2?=
 =?utf-8?B?NEtoOTBpNkVzWS8xRStkVXM4NGRQdm44VVBvMFE2YmhkOTJiMGhXSjZHbG5X?=
 =?utf-8?B?Wi9Xam83cnVTem0ya2VUdm1zVmEwZU4ydDFnUkQxNEw2ZWlGYVZmNUJYRUJa?=
 =?utf-8?B?dTFwQWEwdUNaaE9tVmJUZlF3RmZEU2oySFBKZlcwRUlWcldiVUZZNWZDUGtL?=
 =?utf-8?B?eWFRa2hoMkxuREhneTFENFJDZXoreU9RNklibFJHUHc5V1RSMDQ4V1A1UHF1?=
 =?utf-8?B?RTZubEdZUUtML0VIRC9HQUVockFPTUtVaHlZUUtEUEZOd2JWV09DeEUvSE4v?=
 =?utf-8?B?RXN2RFJobXZteG80NTNqSno0eEt4RGNKZER4RVBXY2tMakNOa2ZGWWVvWnEz?=
 =?utf-8?B?U2FXT2RWdEZ0OU4wenRRS2g4WXFUdExaSUJqeDhBS1hCYk5QZFl4VlEyQ1No?=
 =?utf-8?B?ZURvWVVQRFpLalgwOEJHS0NtaC9aWjRZOEZtNUg2MVkrb2Jla0JlZFN5THFX?=
 =?utf-8?B?WDlSKzdjZHhydXhKQkw4bFoyMkJqanRYd3JURER1UURxRXRqTEd1UW9RL1ZE?=
 =?utf-8?B?NEJGM3RpQVcxTkVQYjFYbEJTRG85VEc2L2hNeTNTaXZyUFhVK0xtbWlENEhQ?=
 =?utf-8?B?K0c3SDNFd0hMQ1hjdWdZbEVSZGc3NWw4NzJPTUd2dGpoNmJTbFNXZHlmQUlo?=
 =?utf-8?B?dTJDR2VRSm13TmJETktOd1B4MWpCa0p2Z3J5bzRMYnU4bXdjTXhKVWtCTjA5?=
 =?utf-8?Q?fK3VxNYky0dlB6K8VI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJRd3A0UTk3c010VitFbDN3ZnVkVmhzc2RmNmxJYUUySUZ5dXVZYmdjazJp?=
 =?utf-8?B?Ky9NemJxRlVlTzRmM0FNenBNZ1VLcEZ6UVBkUExVWGxzdmFvNE5FYkMzVEtj?=
 =?utf-8?B?Vlgrc3BvR3pkZGtXdEJFZ2RpZENrZ1U1a042MHZYSFIwbFZydTVFUXdFNi9N?=
 =?utf-8?B?cWhQOENvNnp4T2U1QVJMWDFvTkZhdlNjM1RFVDhZOEVuVm55R3Fxdkczdmg5?=
 =?utf-8?B?M2xXcG8reHlaQTNTaDhmZzBPT2Q3UUl0VENkRTlBSEMvMFJvQ2JjUlB2TGFI?=
 =?utf-8?B?akpKMXlMNGlCRjJIWElFRWF4aHJoVWRHR3crR0p0aDNMbDMvVVU4TFppbS9W?=
 =?utf-8?B?d2F6OW1kZE9pcWQ0K3RhdTJsYWd2YzZXYWd3VHcxaDhFMFZUZTdjZ2pUMzNl?=
 =?utf-8?B?RXh6QngrR1RFNFhEWFZzdUgyMEhVNXhRU1FGQ0JDQ0o3WmhlTWFzT21wanRk?=
 =?utf-8?B?dzZKSWQrdzJZcTVQRVRaTElaSXFubXZOekxLczBhNUxkakRHckNwN0Fuekxw?=
 =?utf-8?B?U2gzSGlZODlXR3VaMFNYZUxnTnU0OWVDc2xaN0JIYjhISjl5ZXlNTWh4dEU5?=
 =?utf-8?B?KzBTSDlwSVRvODNUUC9xTWtDRXc2NTVCQ2VtU3lHT3hITVRzNUFmYWdHM2xI?=
 =?utf-8?B?bDg5SlBHYWZ0L0lOak0rbTAxVE93a3BWOUZlaGJtbytKTVNlSVBUMTF4T0hD?=
 =?utf-8?B?OWlFS01JeldndXAvU1QzdW5HR1htb1c0VjVRbWorWGNLOS9CZ3ZkV3V1VHVG?=
 =?utf-8?B?d1ljOVlwNzhxQ1NPWUNIaVFScVQ5NVdLaXpiclNzazdudHAycmpabkYzK3l0?=
 =?utf-8?B?SHZza1phTEZMOTFKMVRMS0lwY0tmcStKRWtJcXE3dWZ4b3J6dFRYRHhydm5a?=
 =?utf-8?B?bGY3U1JobzA2bytmc0xRMmlxQ2dkM0J6VXZyZ1Y1YmhZMyswaVVFOXducVpF?=
 =?utf-8?B?aVFBZ0VrUDU2Yk5vakN1Um90dVl2WUZZNnNHS2lydW0yaGZibDRLZDVtWlpW?=
 =?utf-8?B?Z0NYbFVvT1loVDdiZ2tmTktEekRlSlg5OHIvUitjNXhTT1BMeG0vWkZpV3Rz?=
 =?utf-8?B?MkR4U2NJTzhGa0R6SnlUaTZkYTV0VUI0WHI5Y25tQ0VreHdDcW1CWDhGUXNh?=
 =?utf-8?B?M2hwOFJVeXdCL3RsbTY1by9qRUtBaFIzbEszLy9Wd0dTQzBwUVJmOUdtcnd3?=
 =?utf-8?B?Sm1EK1hzMFN2Q1JTSmtRZExQZUVCYVpaVmE4T1g3NVdySVRCdzc3TjgvTC9p?=
 =?utf-8?B?NndObDJ3OGdsNmFHRGh2bGc1MGZvVVZkT3REb1dYcW1aRVZjYWRsT29BNXJ0?=
 =?utf-8?B?L2h3L01qQm5iZ2IxL3Bab09aOUJIMm1KTlgyZkk2MUtEVG9aSndtUGczNHVl?=
 =?utf-8?B?R3p5cDZ5enhEN0FzZzBsbkpmUG9sR0k4TmFaUSs1RFI1R0lHV0kvMDZEc0pm?=
 =?utf-8?B?cUtoRUdXQWJvNW5XRGFZeitkbW45ai9mdGx1ZzdGLzVFLzFkaHF2eVQ0aE1J?=
 =?utf-8?B?VVdRelpiSjUxUjRZbnAyQzlBY1VSUVpoL0h1TkhJeE16SmF2SVNFSGZFbFhy?=
 =?utf-8?B?SVdhdjdFUjFsY0hzMmprVlduTkFFbXhLUDl6bGRETXN3ZThDZmFvVEpQNkNa?=
 =?utf-8?B?QThQT3NmSDFJWm1IeEgrckl4ZzBIdHZDNGczQ0t4SE9rZ0M5VE9wUEVsMkdH?=
 =?utf-8?B?c0FiQTNSRFBmeHVsY1MvbE9tcXhOZGw0aFhNcGsxWFA3N0RVUUhWWlJuYnBX?=
 =?utf-8?B?aXVsUFRjSzBFMGNaWWI5QkhYM3FkUGZWbjRnOWNVbHBWc215RVZVTFdCbi9i?=
 =?utf-8?B?a0djQy96NTNMeGozTTRaeHZ6akM1TllkOUtOcUswSEc3RHdPOUdTWUFrWFJP?=
 =?utf-8?B?cVVSYkI3czZBeWplVnhKcWpwdTRTOHM0QkdGQXVGcm5ZdmhOUklkczc3Y2ZO?=
 =?utf-8?B?cDhwTVl3eW91UkpYUVJIOTllUk1Kdi9PYlpQTGZjeFQ0eDhzNDNnMWZzWUJw?=
 =?utf-8?B?aGNUS2I0TnBIeFBZVTZ3SmxWYU95dlJCR0dmSjlnS3FwVE9xUVpudmh0SWlw?=
 =?utf-8?B?SkhGTjJpMHRXblBhWlRsZG9rd2NDNW1jWFhtZjVSTWVtTXlPM293ZFFBR2tH?=
 =?utf-8?B?UTF2ekFPS2VuZGZyRzJKalhBbTdkazFrcGdGQmQyZ0UrTkFKZUxPUGRzamZI?=
 =?utf-8?Q?TmxdxTwtL7DYoztWj3XNgZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463A482235276A4AA79FE2C9E1B661F4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb14884-3d39-40e1-6a22-08dc73dd0ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 06:13:58.7036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLM6gMKwcklryBc0xSA5XpvX4lwOT/fKdQa/YoQ+pN0Vg6MOZdxoiE637fycDqLR0ZA3xz2fSTmsButy74ZW8w6ri6OLTTrRy9J66bQVouGmQ3/ED+whLVEnqCY/Evth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8788
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

VGhhbmtzIDspDQoNCiA+Y21kDQoNCk9uIDE0LzA1LzIwMjQgMDc6NTAsIER1YW4sIFpoZW56aG9u
ZyB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1l
bnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24g
c2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBIaSBDbGVt
ZW50LA0KPg0KPiBJJ2xsIGxlYXJuIGFuZCB0cnkgdG8gZ2l2ZSBjb21tZW50cyB0aGlzIHdlZWsu
DQo+DQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCBpbnRlbF9pb21tdSAwLzddIEZM
VFMgZm9yIFZULWQNCj4+DQo+PiBIaSBaaGVuemhvbmcNCj4+DQo+PiBIYXZlIHlvdSBoYWQgdGlt
ZSB0byByZXZpZXcgdGhlIEFUUyBzZXJpZXMgcmViYXNlZCBvbiB5b3UgRkxUUyBwYXRjaGVzPw0K
Pj4NCj4+IFRoYW5rcw0KPj4+IGNtZA0KPj4NCj4+IE9uIDA2LzA1LzIwMjQgMDM6MzgsIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9w
ZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+PiBlbWFpbCBjb21l
cyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
Pj4+DQo+Pj4gSGkgQ2xlbWVudCwNCj4+Pg0KPj4+IFNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLCBq
dXN0IGJhY2sgZnJvbSB2YWNhdGlvbi4NCj4+PiBJIHNhdyB5b3VyIHJlYmFzZWQgdmVyc2lvbiBh
bmQgdGhhbmtzIGZvciB5b3VyIHdvcmsuDQo+Pj4gSSdsbCBzY2hlZHVsZSBhIHRpbWVzbG90IHRv
IHJldmlldyB0aGVtLg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4gWmhlbnpob25nDQo+Pj4NCj4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1E
UklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4gU3ViamVjdDogUmU6
IFtQQVRDSCBpbnRlbF9pb21tdSAwLzddIEZMVFMgZm9yIFZULWQNCj4+Pj4NCj4+Pj4gSGkgWmhl
bnpob25nLA0KPj4+Pg0KPj4+PiBJIHdpbGwgcmViYXNlLA0KPj4+Pg0KPj4+PiB0aGFua3MNCj4+
Pj4NCj4+Pj4gT24gMDEvMDUvMjAyNCAxNDo0MCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+
Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNs
aWNrIGxpbmtzLCB1bmxlc3MNCj4+IHRoaXMNCj4+Pj4gZW1haWwgY29tZXMgZnJvbSBhIGtub3du
IHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pj4+IEFoLCB0aGlz
IGlzIGEgZHVwbGljYXRlIGVmZm9ydCBvbiBzdGFnZS0xIHRyYW5zbGF0aW9uLg0KPj4+Pj4NCj4+
Pj4+IEhpIENsZW1lbnQsDQo+Pj4+Pg0KPj4+Pj4gV2UgaGFkIGV2ZXIgc2VudCBhIHJmY3YxIHNl
cmllcyAiaW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xDQo+PiB0cmFuc2xhdGlvbiINCj4+Pj4+
IGZvciBib3RoIGVtdWxhdGVkIGFuZCBwYXNzdGhyb3VnaCBkZXZpY2UsIGxpbms6DQo+Pj4+PiBo
dHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyNC0NCj4+IDAx
L21zZzAyNzQwLmh0bWwNCj4+Pj4+IHdoaWNoIG5vdyBldm9sdmVzIHRvIHJmY3YyLCBsaW5rOg0K
Pj4+Pj4NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56
aG9uZy9pb21tdWZkX25lc3RpbmcNCj4+Pj4gX3JmY3YyLw0KPj4+Pj4gSXQgaGFkIGFkZHJlc3Nl
ZCByZWNlbnQgY29tbXVuaXR5IGNvbW1lbnRzLCBhbHNvIHRoZSBjb21tZW50cyBpbg0KPj4gb2xk
DQo+Pj4+IGhpc3Rvcnkgc2VyaWVzOg0KPj4+Pg0KPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L2t2bS9jb3Zlci8yMDIxMDMwMjIwMzgyNy40Mzc2NDUNCj4+Pj4gLTEteWku
bC5saXVAaW50ZWwuY29tLw0KPj4+Pj4gV291bGQgeW91IG1pbmQgcmViYXNpbmcgeW91ciByZW1h
aW5pbmcgcGFydCwgaS5lLiwgQVRTLCBQUkkgZW11bGF0aW9uLA0KPj4gZXRjDQo+Pj4+IG9uIHRv
IG91ciByZmN2Mj8NCj4+Pj4+IFRoYW5rcw0KPj4+Pj4gWmhlbnpob25nDQo+Pj4+Pg0KPj4+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggaW50ZWxfaW9t
bXUgMC83XSBGTFRTIGZvciBWVC1kDQo+Pj4+Pj4NCj4+Pj4+PiBIZWxsbywNCj4+Pj4+Pg0KPj4+
Pj4+IEFkZGluZyBhIGZldyBwZW9wbGUgaW4gQ2M6IHdobyBhcmUgZmFtaWxpYXIgd2l0aCB0aGUg
SW50ZWwgSU9NTVUuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGFua3MsDQo+Pj4+Pj4NCj4+Pj4+PiBDLg0K
Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gT24gNC8yMi8yNCAxNzo1Miwg
Q0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4+Pj4+PiBUaGlzIHNlcmllcyBpcyB0aGUg
Zmlyc3Qgb2YgYSBsaXN0IHRoYXQgYWRkIHN1cHBvcnQgZm9yIFNWTSBpbiB0aGUgSW50ZWwNCj4+
Pj4gSU9NTVUuDQo+Pj4+Pj4+IEhlcmUsIHdlIGltcGxlbWVudCBzdXBwb3J0IGZvciBmaXJzdC1z
dGFnZSB0cmFuc2xhdGlvbiBpbiBWVC1kLg0KPj4+Pj4+PiBUaGUgUEFTSUQtYmFzZWQgSU9UTEIg
aW52YWxpZGF0aW9uIGlzIGFsc28gYWRkZWQgaW4gdGhpcyBzZXJpZXMgYXMgaXQgaXMNCj4+IGEN
Cj4+Pj4+Pj4gcmVxdWlyZW1lbnQgb2YgRkxUUy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhlIGxhc3Qg
cGF0Y2ggaW50cm9kdWNlcyB0aGUgJ2ZsdHMnIG9wdGlvbiB0byBlbmFibGUgdGhlIGZlYXR1cmUg
ZnJvbQ0KPj4+Pj4+PiB0aGUgY29tbWFuZCBsaW5lLg0KPj4+Pj4+PiBPbmNlIGVuYWJsZWQsIHNl
dmVyYWwgZHJpdmVycyBvZiB0aGUgTGludXgga2VybmVsIHVzZSB0aGlzIGZlYXR1cmUuDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IFRoaXMgd29yayBpcyBiYXNlZCBvbiB0aGUgVlQtZCBzcGVjaWZpY2F0aW9u
IHZlcnNpb24gNC4xIChNYXJjaCAyMDIzKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBIZXJlIGlzIGEgbGlu
ayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4gZmluZCB0aGUgZm9sbG93aW5n
DQo+Pj4+Pj4gZWxlbWVudHMgOg0KPj4+Pj4+PiAgICAgICAgIC0gUWVtdSB3aXRoIGFsbCB0aGUg
cGF0Y2hlcyBmb3IgU1ZNDQo+Pj4+Pj4+ICAgICAgICAgICAgIC0gQVRTDQo+Pj4+Pj4+ICAgICAg
ICAgICAgIC0gUFJJDQo+Pj4+Pj4+ICAgICAgICAgICAgIC0gUEFTSUQgYmFzZWQgSU9UTEIgaW52
YWxpZGF0aW9uDQo+Pj4+Pj4+ICAgICAgICAgICAgIC0gRGV2aWNlIElPVExCIGludmFsaWRhdGlv
bnMNCj4+Pj4+Pj4gICAgICAgICAgICAgLSBGaXJzdC1zdGFnZSB0cmFuc2xhdGlvbnMNCj4+Pj4+
Pj4gICAgICAgICAgICAgLSBSZXF1ZXN0cyB3aXRoIGFscmVhZHkgdHJhbnNsYXRlZCBhZGRyZXNz
ZXMNCj4+Pj4+Pj4gICAgICAgICAtIEEgZGVtbyBkZXZpY2UNCj4+Pj4+Pj4gICAgICAgICAtIEEg
c2ltcGxlIGRyaXZlciBmb3IgdGhlIGRlbW8gZGV2aWNlDQo+Pj4+Pj4+ICAgICAgICAgLSBBIHVz
ZXJzcGFjZSBwcm9ncmFtIChmb3IgdGVzdGluZyBhbmQgZGVtb25zdHJhdGlvbiBwdXJwb3NlcykN
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gaHR0cHM6Ly9naXRodWIuY29tL0J1bGxTZXF1YW5hL1FlbXUtaW4t
Z3Vlc3QtU1ZNLWRlbW8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAo
Nyk6DQo+Pj4+Pj4+ICAgICAgIGludGVsX2lvbW11OiBmaXggRlJDRCBjb25zdHJ1Y3Rpb24gbWFj
cm8uDQo+Pj4+Pj4+ICAgICAgIGludGVsX2lvbW11OiByZW5hbWUgc2xwdGUgdG8gcHRlIGJlZm9y
ZSBhZGRpbmcgRkxUUw0KPj4+Pj4+PiAgICAgICBpbnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRj
aA0KPj4+Pj4+PiAgICAgICBpbnRlbF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIGZpcnN0LXN0YWdl
IHRyYW5zbGF0aW9uDQo+Pj4+Pj4+ICAgICAgIGludGVsX2lvbW11OiBleHRyYWN0IGRldmljZSBJ
T1RMQiBpbnZhbGlkYXRpb24gbG9naWMNCj4+Pj4+Pj4gICAgICAgaW50ZWxfaW9tbXU6IGFkZCBQ
QVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCj4+Pj4+Pj4gICAgICAgaW50ZWxfaW9tbXU6
IGFkZCBhIENMSSBvcHRpb24gdG8gZW5hYmxlIEZMVFMNCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICBo
dy9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA2NTUNCj4+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPj4+PiAtLS0tLQ0KPj4+Pj4+IC0NCj4+Pj4+Pj4gICAgICBody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggfCAxMTQgKysrKy0tDQo+Pj4+Pj4+ICAgICAgaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmggIHwgICAzICstDQo+Pj4+Pj4+ICAgICAgMyBmaWxlcyBjaGFu
Z2VkLCA2MDkgaW5zZXJ0aW9ucygrKSwgMTYzIGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pg0K

