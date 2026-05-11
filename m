Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDACCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 06:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMKAZ-0005Ec-1C; Mon, 11 May 2026 02:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMKAM-0005CY-KE; Mon, 11 May 2026 02:31:02 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMKAK-0004g4-HY; Mon, 11 May 2026 02:30:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0ue8PslRXuKRhqDEI5h1n0kfmu4im+BJy/MBCjSR3EQSeJBhSvF4oP0+7JfTm9PPbCjERZ4d+r+e8Mhj0/N6l+TkB1DvHqbnzwZfJDoldzB2W/QmwHR9wthh/Ayl/+c1ZVTxm6b4rjVcEDTnlqZoQsrGGRxk3umIfwgv24CNtEK/A7ZkZGPfqRatd40YrVr74JIiYn0b18/0y5N+gM5/3PbfKBex9+CTxrfbYgP1YfdJq6iAHN/27WzI3JR/rvpzS9lQIEd7A3BAD5g3apUgCGshfwp/9niaAe2eLsVoDnB7hJu1Fci/yBKLrva8j0X3kdN94UC5Ch9D0iLEMfIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ls3rT+3ZYgsx1xDLzx3KuYWBi8L3IEP0LCj9cGBMOE=;
 b=amHEm7jhnZ/bGfQFLdeKhkCeIpCAKHqStipAa/qkzihJBUDVECNCodoGo+2ZQW81nsqUGh0sVER7oIejNTZbPJL7wLRNVtmwI6iEDFx7p62cI76Y23cBZI6LI/4KoOyILWDrJd9fMH9aQOVzHIaVqC/Mdoa2P2X5TbkI+JEQyKzV9IH3BK7OvkQ+KHQMaDBGLXRgtYQC+J7waPEDUi344nju9B7heJbqRLQlLudRsN/GWjmRupBP2fq+oS+c6KPDQa8yXyfWeZEXuik7ZbYl6lSewVSuT7PuBQq4rdN/GE8x6sgWQbrZlgDieb6ERU+VVWXiF0YTlY0TPk+FG51yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ls3rT+3ZYgsx1xDLzx3KuYWBi8L3IEP0LCj9cGBMOE=;
 b=PjHZSqAjNRcKJsZDU8un+WigpyRrMEw2+eDVWuPziEGnZv2NP11uMru5GGwZ8Ycluecgyrx2cbHP7zuCI9FYHgD1My1coklvFB3m8IKZ0/oF3q02YD/Ww2NYBrCrQbtTJbJgo3BB/KawqCXA4llEbsI7tolY2Z95UQJ0VgtC5VB3wLBwpjI0l2NlJH36mJ1YHBjVbji+EImPUnB+L59t1tef7BJ9U0OcDnD5lBuI2EqcskaC8eaWnR0xTW/EJgVvSjipdy8cIgEN7Gob7m1CIUN1mOXNmLasgCus8G3/OiIY+CdlSLyja1K6QSCAw/jCA9d7pxSTiy+UMLM3y+ublQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6060.apcprd06.prod.outlook.com (2603:1096:101:ed::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 06:30:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 06:30:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "philmd@linaro.org"
 <philmd@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Topic: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHc23E4Zae50w4sSUmC3BP0jFUSeLX9Vo2AgAsNHwCAAAOIoA==
Date: Mon, 11 May 2026 06:30:45 +0000
Message-ID: <TYPPR06MB820617F90DCAF66D872A9279FC382@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <0abcf804-f16f-43b6-a345-e14642e54718@kaod.org>
 <5fe87f4d-9c44-44b3-a684-511d243f0f75@kaod.org>
In-Reply-To: <5fe87f4d-9c44-44b3-a684-511d243f0f75@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6060:EE_
x-ms-office365-filtering-correlation-id: 3d6329ab-ee41-4913-55b4-08deaf26d58f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: MjJmbHjebPpQifEsDTQZE+lqGKDJlD+wKlVO48FlgsxbOjkC3vIyK53o37QHoAQLJA9gvQKwpa67aVy4BnPgxAbj3AkuyTUuuk9KO/6RCY2ZPcqRmJjEJIfa5usNEx5VKtvxyT9NoQjwmMiKiuSNqaTvtdtO+yW4UyRdzM1+sxQfRmTg12iTP0au/UIR/rrr27Du6cLF2knx/nEDkUPq4AJJdxkWpMdpqKClodfkgXs6aMKGzey3DIcNPzn89Ap1URcGtbUmXyWmW5aElLn4dSgd6hUYVRba0WSDGr8mWT5WEO27DxtVbDIUVjtOAztxvZBaVgWNZRn7TPLLrpZS+4jjXwU797VKqQ6H1WlCR/2kkSiA5yj0VEif4BpxrG1tL+s5R+PGnTUonCfsnR0/wAk8YFI7o2XQkxgA99kH688A0yoB9lw4DCbgLRFDy4uyFNW18HKms29UXUfCfZ50xN/eni7Km4Xc/ckhOjGa35dz6ml6al5tsoTJUo5hddfzA1bck3ZJkINu34FRCgMWeGR6t55Kl/6S5rjlUMywmcYmxGJjxJdO6is+ACZ360G89iMQvV7TuUR0VWCdD/SM+9e73q14dPXTHt9vXAeTSGaVM1Y9ZMEbJda4j75x03uAaPF89/zs4tsDj3O6M3h1TKeEAwS7/MWwG1jBlzjY5Bv+8BB1Ri4p6OFczcAEvGbf7+vkOKqHxlV/qpVmbyU7ULMAoRAzPDAyTTlU0XKTXsEX2iUTxVCUlTD3/pVV7ybj29bmy26LNnPgvHePNDTkOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmJXMENrenJFWUtPdUlwdUY5azBhRzE4T0VXL2Z1WEZKbWRxbHE4WTZoSTlS?=
 =?utf-8?B?RUFnSm91b0lBUVZUN0NIL0pUUU5WL1kwMzdmaVZuNVdFL1JvSnlieVpjNmh0?=
 =?utf-8?B?bnNnNksvdUVseHFuVXcwSU9ZcUVzNlA3UUZ6RVFKRnM3MzJldlpmV3RYeFBN?=
 =?utf-8?B?U1V1TXBuYWtsRkFsRXR3VmM5UzJSSFd0enZlT0V6N25uVjJpQkNoNUpWUDBF?=
 =?utf-8?B?eTBBSExmR3JjVm9oTXgxVzR2UVJsRlR0QkJmTmdDL2hZYXNPZFVVcElnUGdB?=
 =?utf-8?B?cHh1Q0FUT3R2cFR3OFdGTFpjdzQzcDJZQ0tyQng0dlBoQURkcG4vbWNZT3Nw?=
 =?utf-8?B?TUhsdGxmUTVmSGVLdFlnS2lmYkhIZlFFQktCM0liYXR1NDhFTE1XVTI2T3A2?=
 =?utf-8?B?dFUvU0taZ1cyNktKa1pBbjhhc1QyREpGeWR1ZHdnM1o1VXUvQU9lTnZpdHRw?=
 =?utf-8?B?dDVpU1V4Q1l4Y2xpR1ArejR0c3BBQmsydTBnVXgyaVhyU0JCMjJ4NXpCRFBm?=
 =?utf-8?B?NEtNQUFPc0YxZjVPajhRaE84WkRkbkM2K3hwWElKbzloWGxPUmwxQVRpeGsz?=
 =?utf-8?B?bW9YYVJQR3dGUlo3aVhzZWd2YVRmSXhlcTd1ZW9TV1BhS09mTVhPS3V2Z3Jv?=
 =?utf-8?B?c2dYRnpIdmV2WlVzdEFTNGpoRVUwTDBFOFNJQXhpbEFJcWo5cS9SRWs3QURL?=
 =?utf-8?B?anpham50U1JjUEs4NVAzK1p0VG9jOWcyRlR6dUpmRWNEVmJnTDFNL2dnOHd1?=
 =?utf-8?B?Szk0OEZGWmVPZTZQZk4ycE5QdkkxSjhOV2pmMVV6WDN6a1ltRXFLUUliTlJ4?=
 =?utf-8?B?UUVrUC8rTVd6eEUyOXZNbG1sQTdmaGUxWEpzNTVGTVJDYXNJTXhxbVphV3hF?=
 =?utf-8?B?TGpIemN2bDhDRDI2ZGR4WWV6VGUwOVhtdUZ3TVV2a1QydU13Mjd5OWd2RVlC?=
 =?utf-8?B?VXV0YWgwWnhZdytsOEdvWnNlclZnMWVKVFNaMzlyN01DUzYyYVBNV3h0MFVw?=
 =?utf-8?B?bm5PQ2lLTDJaY2tGRkl2dDRWelZXVVc3SG81UFJ2NCszYlNZVEI2VEpkNDdy?=
 =?utf-8?B?U1JpL1NORFI3RDcwQkh6YnF6SGtEU3JLUFhoYURIN0RVUU9qWjVWdkpMWnQ4?=
 =?utf-8?B?eU54UVZxbCtUN2dpMlptVXNqWDNoODJKZHZHbWM1ZzNEaUV0V05uN0l2TFR0?=
 =?utf-8?B?Y2RaMVU2R2JrVGMxTisvcWZySVl4WWIrZFE5K09DZm8yb2h1ZGg0MkkvUkZo?=
 =?utf-8?B?aG5pUG10RGVWdFE5eEk5Ry9NWHo1WkdWNFphOXphTTZwT0Y2VFgwQTdkb1Jm?=
 =?utf-8?B?ZFJaTVRyRnNRa25ZMFowMTJrck9MdWxkZS8vdUxoSGpuK0xJSlpYYWR5SDNo?=
 =?utf-8?B?c3ZRMnhIREVxU0x5ZWZ1bCtXZ2VIR0JVbldpekpCUjJIcFF6bi8vV3M0aFA1?=
 =?utf-8?B?QWJ0bzNmZFlsdjZuUzF4Z1dZYTRuZlloc1FpUG9GSlREdFJWbnZiVXJ5YU4y?=
 =?utf-8?B?MmdBTUxFM2k2Q04yMW42ejNQb3BiRklZdk4reEtzYmdaVFoweGtzVzRUcTdy?=
 =?utf-8?B?cTJpVWFRVXZZVk1mZzFHTkV4YmRNelplMHpVSkp0OHVzYTg1VExSc0gvNGRr?=
 =?utf-8?B?V3JsZG5PYXVkK2YxODdnYWRsZFlKYXhJZFJBbXdqZVkzT01aOGpPd0w3dlRD?=
 =?utf-8?B?NW4yQ1N3bEV6VzVPdkpZSFI0MHBrbU9WSGgxRzZqR0lybHBOUU5ISElLbWVx?=
 =?utf-8?B?bjlDbGlHRk9FbEY0TUNvdHowWlFhdEpQL0ZndHhpZkwrUzVJM1JyOEZLbWlN?=
 =?utf-8?B?NHZDRVhJOXRpckpRKzgwZ1BMOXJybEFxMDYxSmltWmN4WHI5alNzVDV6WDIx?=
 =?utf-8?B?Z0NORml4MGZ5ZWtCWXpIelByZCtMNUNhbE4vQmJ2RzQ0dzE3K1VjU0EvaVVh?=
 =?utf-8?B?WkNsWHk5QXVvRm9KQzAvbk1tTGNmZi9vNHZBVlowSmhoWE1Cbnl3TThkZWU2?=
 =?utf-8?B?TnpleldWbXYyT0ZNaU42YXFEM00wRW1wQlNCbkgxUDhWaG9KRWZLc2tackxy?=
 =?utf-8?B?a3NGdjJDRmZ0amIwRDI1S2c5YkJMcE9uS255dVFCMUxYV1FBZ09EQVF4dFpo?=
 =?utf-8?B?aHhHOXRqVlp3S0VhN0pkQWx4MWxUZ3NpcDF4MllCK2E5OXRDVkRxRWJwVjg2?=
 =?utf-8?B?cW85SnliNUVJclg3UWlNdzZad21vQ2VrWC9EYlU0L21CZTdmM1ptMXVuY3gz?=
 =?utf-8?B?TVJuYUw5RHRabFdyZGE1ZzhvTjE2L0ZFNFhiWDh0alRKRFhzQm9oV3dsQ3dX?=
 =?utf-8?B?UVBuNDlzTkpGVlhxZmJJYyt1MXFRMTJ0NXpnNGNGeWpmbG5zVTlGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KHnHyZ0to6SnXkfkPdTIueEj4jDyYnonEKRHE1vZ1bk24+41doIGEr8aZ51xwBe7g7o58Gnlmov88sKWQElDTnTE2C3o0WVATUBNe6+aBpWOdC+wao5CNX0toDgKkmko7dS+GoLB+cpsrIY2njDW8yn88vFhkrcR2aMT9umvpnWVu5Vl9YO9zW/KjL6eVY9r8OH3XhILq5LF5oGJ8gG+FjQ8nHJpmeLcTrbUlXjf7Yqa4pwrcVN2L1/k8Lq74YNSwDxmcrQkS+1goVF4mKGnVVRBilLSgwbfhCz2MEtOweCI4Q5xTB31HFP93ct0XEv/GfAzGCXgQ/baOD7m7q2CaQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6329ab-ee41-4913-55b4-08deaf26d58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 06:30:45.9504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCX+l/18S3oFvq71mcWDtlAN97wHD9H46VxyQERQNcKd1GNKZC/pF9L7bkyOJ49MTAJ2guT6mWbISxGIfXjZ8171Ck98tdCNLZCv0Wvi/KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6060
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgZmx3dSwgTmFiaWgNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAwLzExXSBody91c2Iv
ZWhjaTogQWRkIDY0LWJpdCBkZXNjcmlwdG9yIGFkZHJlc3NpbmcNCj4gc3VwcG9ydA0KPiBKYW1p
biwNCj4gDQo+IEkgZHJvcHBlZCB0aGUgc2VyaWVzIGZyb20gYXNwZWVkLW5leHQgYW5kIGtlcHQg
Og0KPiANCj4gICAgdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGs6
IEFkZCBVU0IgRUhDSSB0ZXN0IGZvcg0KPiBBU1QyNjAwIFNESw0KPiANCj4gVGhlIFVTQiBzdWJz
eXN0ZW0gaXMgb3JwaGFuIGJ1dCBpdCBpcyBzdGlsbCB1c2VkIGluIHRoZSB2aXJ0IHdvcmxkLg0K
PiBUaGlzIHNlcmllcyBpcyBtb2RpZnlpbmcgdGhlIEVIQ0kgaW50ZXJuYWxzIGluIHN1Y2ggd2F5
IHRoYXQgbWlncmF0aW9uIGlzDQo+IGltcGFjdGVkIGFuZCB0aGUgQ1RSTERTU0VHTUVOVCAoQ29u
dHJvbCBEYXRhIFN0cnVjdHVyZSBTZWdtZW50DQo+IFJlZ2lzdGVyKSBpbXBsZW1lbnRhdGlvbiBp
cyBpbmNvbXBsZXRlIEFGQUlDVC4gRnJvbSBFSENJIHNwZWNzIDoNCj4gDQo+ICAgICBUaGlzIHJl
Z2lzdGVyIGFsbG93cyB0aGUgaG9zdCBzb2Z0d2FyZSB0byBsb2NhdGUgYWxsIGNvbnRyb2wgZGF0
YQ0KPiAgICAgc3RydWN0dXJlcyB3aXRoaW4gdGhlICpzYW1lIDQgR2lnYWJ5dGUgbWVtb3J5IHNl
Z21lbnQqLg0KPiANCj4gTGludXggZHJpdmVyIHNlZW1zIGJ1Z2d5IHRvby4NCj4gDQo+IE92ZXJh
bGwsIHRoZSByaXNrIG9mIHJlZ3Jlc3Npb24gaXMgdG9vIGhpZ2ggZ2l2ZW4gdGhlIHRpbWUgSSBj
YW4gZGVkaWNhdGUgdG8gdGhpcw0KPiB0b3BpYy4NCj4gDQo+IFRoYW5rcyBmb3IgYWxsIHRoZSBn
b29kIHdvcmsgeW91IGRvbmUgdGhlcmUsIHNwZWNpYWxseSBmb3IgbWlncmF0aW9uLg0KPiBJZiBz
b21lb25lIGNhbiBBY2sgdGhlIHNlcmllcyBhbmQgc3RlcCBmb3J3YXJkIHRvIGJlY29tZSBVU0Ig
bWFpbnRhaW5lciwNCj4gdGhlbiBJIHdpbGwgcmVjb25zaWRlci4NCj4gDQo+IA0KDQpKdXN0IHRv
IGxldCB5b3Uga25vdyB0aGUgdXBzdHJlYW0gc3RhdHVzLg0KSWYgeW91IHdhbnQgdG8gdXNlIFVT
QiBFSENJIG9uIEFTVDI3MDAsIHBsZWFzZSBhcHBseSB0aGlzIHBhdGNoIHNlcmllcyB0byB5b3Vy
IGNvZGViYXNlLg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IEMuDQoNCg==

