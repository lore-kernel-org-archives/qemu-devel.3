Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A3AFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbOw-0001kA-US; Tue, 28 Apr 2026 01:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHbNc-0001Yt-5s; Tue, 28 Apr 2026 01:53:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHbNX-0002G9-ON; Tue, 28 Apr 2026 01:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlf1+laiMND/HudOnXOWaDtiNIK/qsk4O5RAoSdgu2umNMXk8Fr3MV1EDD6osQl68UGFJjogR5xUOR8fOUJlrP98hDqakNfWn7QJCf+wZQnpTs9F6pRr4j+7gw33B4L1vMQTfeHwUS3bJXo61uRoqjNYr5NWS1P8C/hZ18oeLuQfjIEi9Y9vliW8ThaWNqcnEiM8q4/mZByF9yodUiZ2z+SD+xLZmh3H9LtGUN92t82TvVNnTAFQ1rWad0HQP2bxmkMnaA/FWyn91MJDJNJaV+OkTQeAnEq+MlZj3BIkxGnavJMRahfnU4CcT88FQZozriv2wPq2usS56R18CuOGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyipqzX6uxXXdrNaRq5oHr90uBsHqBlh9dpeMN8rTzc=;
 b=vx8HZ+j/Dy1U0biI6vy6bsW/PqEVusLbZ6aJUO3ywDKGQAb8n+CCRTWPMkDJA9BayUWIqPp0FR7fYnbCVmvWUcNnsfE+981gAs8m/olGqRq/bZ5iBWb6SHrFRPJnT1VOM5ETtih1GMb00dUxYdQI/gXqe0yJSKQzjFDKvixQwv71xxxJiRFULDe3J4kq8cfYRGFunJT8p1+2jxdCBl3yGNlUon/8NpxsDTr0ZYN5E3VuSxSV175N1EbpQXF/RBb+radgicc/cWPSaLSNSXFkSzyDrWIOCy7HO+JMHmp8w3s4qTQL5xap02/NoNreOYEgjLh+/c17lsrtmGsyeKb/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyipqzX6uxXXdrNaRq5oHr90uBsHqBlh9dpeMN8rTzc=;
 b=E9EJDS6J6kkyBgKk7Bn8/x9VWDkvPbY6Lz63NjSIDkRq1JUJ7Mb9Uv+hl+yU8BiEtlA7tQf4qlKDovzgaJcQlEvIH/KTwlWE5BzXAn9zhYuqEIrdWGRRylvxu9jCzlbJ0MrzJ5kLuFA8WEMpVU/NDzkiIJA6pH5sLglnNvTo/T2JuCQInUkCI8kgX9QSkrrmVhyll6mhgHzz7WhD48gPHkZKxtfT/S67vIPwgGwdNa4Pk5gAebOX+SAKMxoFCSBEjay/p0yYkYW31WjGAlpnTqJYm20iMyLlxODrkigSn6lSF8xFhAErtG3Vr8z8PqgFniWBJVOXNLQGDLbLGvR5qg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6073.apcprd06.prod.outlook.com (2603:1096:400:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Tue, 28 Apr
 2026 05:52:55 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 05:52:55 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/1] hw/misc/aspeed_sbc: Add bounds checking for OTP write
 operations
Thread-Topic: [PATCH v1 0/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
Thread-Index: AQHc1tNCG4WknDPCO0aJKjbbCZMokQ==
Date: Tue, 28 Apr 2026 05:52:55 +0000
Message-ID: <20260428055254.76581-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6073:EE_
x-ms-office365-filtering-correlation-id: a36d661c-9529-4e6f-8f0b-08dea4ea64ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|38070700021; 
x-microsoft-antispam-message-info: 5iOESOYd82Ik32FjoTIPg3u0QA642/XTe+lUCn3y5lwRFshqMutCskHiEnCvxGEziFDEQrklmN3WY5ClbTzzS1/JNBN9AYvEYekj25GdSNhVeSV2LZExJvT0KWC2O91Im7XQXjWlzTpUGShCtD2eXfKyLddKgsOykRNww3CpyhP5/uKPRHePeglEf6j/JKgiEm9qghr7HiKNCj8X4UDwsx0i11VnOzDgjZbiZMHiHoK6/1jofx60u/UxzQq9Te0HglM0rTkRPBxE7keZNce6pjcqLoRuA4gAJ+aDngDi+aU5gDHcBXHA0cVMKp+r6YusOCivPi3dQtCKiTttRvLVQ90cmip05kgcvoK+TXm68URh4JeSlosalGvzGSwpcy2sYM+f1gyL2auV288n83ZG42tMUp8/6nib+RjL/hEdBiY9l+LGrwV7Pp+d8o5AWQI7FnJkmi0eg9hetSQdcMDdUZSp+ZoKy3yEYSa0Hd7P6GrmU2Lz0DOyG1nAXhsSV4AsA4gQak9C3sR2Q38OD7YpR6e0yJb7N/WfKFjymVu8JsINC7BTxtXiSCTeY6M1C5yhE9WCJS6vKSAu4BQZq4//WHbvITQagBntsESAVLYLVhc3iuQG9c2rQbBEqllwHf6rMjIza2vw9JGVGHl9VaEya8QKLBPZhYNBs8bqXWhyWr0/E52RlYEb0Okiyb2XZZmEm+LqJEBG46zgiQoQxfY1LdsALyOnyYDFBqEGKi2/JMgJ1Zs6IEBEzJORS5WJf7lIO3sajOlqqjvTq8I4m0YJI66Wjz5vOkoGEq+uyttgNC8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bz+ArDMlWcN2XdIm4+w1v/zgD4xmjGKbo05ELL6x3Ij3dHR7/58BOTAis1?=
 =?iso-8859-1?Q?QN+0WRIpnV6SYuFcgDiDnZ5Ob6oSg0HEzVIa3Tng653YQ6bSFY9HqH15Wx?=
 =?iso-8859-1?Q?BZP084W4cIi9JyVJQi/lK4hFY1Jd0djYgLZZyHDQfWg3TR6/nUZaY6Kwe6?=
 =?iso-8859-1?Q?6crfpkbnRqlCI6eWeNIkf84CoeMtG/vGnvXXlfWSa+aCohESWY6xbNBifV?=
 =?iso-8859-1?Q?PqyQGggKUQvuAkjGe7pjL6adrC78RNbFrtfVNfPB1RKwR7lWz10j3KD1G0?=
 =?iso-8859-1?Q?AanhwZyUJC4QWakC0SPPPC0yEq0FvzgofClsmdnpYp3wRZHxKQ0D1a9i44?=
 =?iso-8859-1?Q?1ZsI1IqRI5op+vTnlbFgxJTna6vpxhVl2afxNpKqsK9eFxYCBlWV2Pgwkg?=
 =?iso-8859-1?Q?75q1m8wRihU/Yy5eAPByyG7qQ/mWMnyLb6ZprUhPoQxPbkUo6swhHdxXdI?=
 =?iso-8859-1?Q?PnnE6De1q9dsB4fdSjKKHBRC1xRsue3jWnpIbCMa1c03Vjz6Q0Q1NOChZ6?=
 =?iso-8859-1?Q?bri6CgLmA0BntIbxZWktT1p0dceCD3j1NPT5AdfS9OGWdXWGjogAqVQcZa?=
 =?iso-8859-1?Q?Jifx+3sWg5z+SqninyznQnKpYROsuzEhQe/EoLVlLIBPlkA/CjMe0tl0XQ?=
 =?iso-8859-1?Q?LQeCSyDEHnlCHivHu9NWSPBcGcXDzsoHTrHJMbNTfTKE08k/X+X/c4/H3J?=
 =?iso-8859-1?Q?Rqyo+hyeTyLcCMqsohbZHJ/s4idAu4aXSffwbkR0pjWVg6buhX0/K5HSEQ?=
 =?iso-8859-1?Q?lDBQ/qfBkziytEnKzhYIYJjJ5Wn53FIjsNHlhyMKIa6Kv5ttsbiClfFKa4?=
 =?iso-8859-1?Q?Gn0fDTzDTv9+pmwE05WUhOZIKtc9RwUd/Ju2OJrrz02a9IcYByBF5KOE7d?=
 =?iso-8859-1?Q?A/RDjlRHmY+QN4AYUjG+FhsNFLgB8RAclnchotEYTwJrP4HyeWUrKzsHc2?=
 =?iso-8859-1?Q?Is9FOp63QXI7MyE+N5UFTMs2cXFvqTkkGZop19P6smGwKVl61IqjvtYFyf?=
 =?iso-8859-1?Q?LQW6LK0B0eBdc9Z0w1StoPbECgCWEBWfZTSmfe6hQzGeZfNHngloyPF9YL?=
 =?iso-8859-1?Q?iH7qRcNCEbaByraA1gNA4smb2dL2joThCpYEtRjZ17xNOOMEATi0jsq82g?=
 =?iso-8859-1?Q?qs9B8/YSRl6rDLXC0UXok3QgsI2g6oxrWQZzYLnmFXSdcsPXApstkR0DkA?=
 =?iso-8859-1?Q?/RdwwHkxo+cPndaP0NRmGC/jsNMkq4VUUHkKxBxqDJdavVUq6zrBOqvDkI?=
 =?iso-8859-1?Q?WE03yuOp5WJXxyT4T+ufAqDqw9wWK397zcVXmpOM5Ilmvzc6xEFEptBnCW?=
 =?iso-8859-1?Q?lPW5KDv7fXxF2UVjxgnvzG63FJun5X3hQ9he9bPm8/uAz4it4UFRJ7P+xY?=
 =?iso-8859-1?Q?xsbUbUrfGNwx3hwZuA5UvxSWy19/c5SV9/qHeP2ekVmJVch0F4wo+swho0?=
 =?iso-8859-1?Q?vMtS2daScjdXH9nlg8WWfmhhT/qmVl8gcaWi6jrZDljZY1+ClsxkEr32na?=
 =?iso-8859-1?Q?Tg3HBYOsR70cuiLS/qKN+X3/dXe8Ef0HtUNwH8EcekpMQnbqfNVO9hCjiR?=
 =?iso-8859-1?Q?K57jDREksqDyrr8kLhD+MIvVmBqoXikOA9YEhdACHkRhSLWMijQJ9rrmAC?=
 =?iso-8859-1?Q?twjw3vkfXNsF3hVUpXe8as95WU9tfVXc6QDmnuLKgg7BHtWc40BAHnKi8Z?=
 =?iso-8859-1?Q?nZcicn6qKurk8oEC+2ys2LRZK095jjUpK13AnZhlrqUsg7Z4x8E8hk+mQ2?=
 =?iso-8859-1?Q?icTtY1RcLrYiVdwCw8oKFSRl9zYuIQOkBrhyQ/TW9Hu9BXBAVXxvyzqqYi?=
 =?iso-8859-1?Q?2XDVqf7uIg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Su9eppooxHDoX+czZVt3Y3452U5+xBVgSdeoXjltJ52ybUMU84owuVX2bbCTOfNDqd1lQ8kubPzDl7G+4SKNmwTAtdl/aTTjCK9TvZSVClXqqTGmD124cfwp0WGAWxXUyk+jRN668xfGesqzYOzg5tTc4rPBlbYORce6D1/HFaImAWcUddYN+mlPlPVWVzA7/8D0hL/mZAEfDgakW3KLZ2ZV/o6CO/A92EdlEWo/KOAJTw4VNAGT1jj36jjB9Oed4BSZzknMKZIBQcOkQ/N1Yc6zUpoXrbqFDJugnVrxYVUc/k0M+gd595fPPKW/EDR2km/fVrFTLuGkU35sXU3E2w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36d661c-9529-4e6f-8f0b-08dea4ea64ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 05:52:55.3584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkoU3SIHaMWd9vDHZczPAQakDeV1sbWBvy+AJu+beSQVjpgk/aJgkM3NLp/iK7j6BsbFpConXdcsyND+HHFuw20n4A+qXUOQi106WlcTaK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6073
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

This series fixes a bounds issue in Aspeed OTP programming through the=0A=
Secure Boot Controller path.=0A=
=0A=
The guest-provided OTP address is word-indexed in the SBC model, but=0A=
the OTP device write path operates on byte offsets. Passing the value=0A=
through without validation/conversion could lead to out-of-range writes.=0A=
=0A=
The patch adds bounds checking in aspeed_sbc_otp_prog() before=0A=
converting the address to a byte offset, and aligns the OTP write=0A=
helper interfaces with byte-offset semantics.=0A=
=0A=
The patch has been validated by a functional test and by the boundary=0A=
test documented at:=0A=
https://gitlab.com/qemu-project/qemu/-/work_items/3436=0A=
=0A=
Kane-Chen-AS (1):=0A=
  hw/misc/aspeed_sbc: Add bounds checking for OTP write operations=0A=
=0A=
 hw/misc/aspeed_sbc.c  | 14 +++++++++++---=0A=
 hw/nvram/aspeed_otp.c | 13 ++++++-------=0A=
 2 files changed, 17 insertions(+), 10 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

