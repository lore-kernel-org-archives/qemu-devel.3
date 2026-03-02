Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FA4D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwtvj-0005qP-DJ; Sun, 01 Mar 2026 22:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvg-0005pt-Nr
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:46 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtve-00008k-B5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrbFb4UoXrKTTwTgA0TrFiGy/tMiih27U4IlMe5n9CkRMblqZ15D1rWMtC4SqPMnccS2v/KuyKe5QEy9dY5QTeAMgfC1Cf7rgiCWFXVKal/RfjvOhiM7YTZa0iXgbDFBsI5+9qhVDa0C0WzH+YDErbMOGebQu0rVmh4y2+YRDSz0k/tX1LMtT9wrDJrcvm3hcKAle/d6IBTGZGVh3pcmiu5iaQ2qnsTISEIGg9iMZfXEPc5GN7mM1kveTk89+lvf6ziwvjoD8Yd2RtZZTsQjjJ2haa7WljmTqxxpopjeLYyWzco42rVV6qXce2VyWuAgt2NtpAju4RzlQ9hJbrdynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zky49kl4za6IIxpcfwVCkPGJ48G2ldq8lWhOs2v+c0=;
 b=BbXNC4aHS4CihPCq8WxC3mu7vfi0MVS9/PS8crwnLDcjoCHbO0ASMrN1tt7AVRWzRLalyOXlyLdabai6epn0M84ns7eJ8CSgiuN3dRqOdgsh3aSS7TtZ4z6wzXoxgugOhaDRUm9WrdEZLqPDZD9Jx+ljjddpSjghvr+NvAOkTZGzQzEoxx8I6s7ttAzd5eM/TuUyvd0BwZC0NI1c4apM1KYdbMumfMcfNrTyvw29hiGmHGYbvNpOXAvNZNBF3fI9i6RbCkXTgH8n0R53L6HrfvMQyajnyE5mpePcguhPvAl7Lgmrjjf0DZAYykm2pHHjsdFd74vcDhaAt4t93U06Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zky49kl4za6IIxpcfwVCkPGJ48G2ldq8lWhOs2v+c0=;
 b=mIHwYItn2Fj7co/+CV43QuocT7DtzqogXc2qJ1ycFyKtMxREbptb+zN60e0Bs2jSluZ1jSbiBxYxGuG8Xau3fNb8Vbg1aTXs4pIjKVa4ZqH9rPxHpa7qQk/asEPYPSRzwhDPKyaiJ030PG4NBtrbXj7KCfBC2zsUFR8VW4xtY7LFIGMddcR11TgrKiZtvDZ/Jtexyy0uFTS9GEFuLeAyYncN5Ge56YOUXbe4L5pwHA+9v/cZUUrHU35dysofFvBFhY1LYjaPKfO6/EOnajJFFOUEG0PFQl6n/zcyVuPiV0sz+iCTcrRcOoZ77VgIuAZJMS3Qt8j6XVR69iKSrwCZ9g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6791.apcprd06.prod.outlook.com (2603:1096:820:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:26:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:26:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "jithu.joseph@oss.qualcomm.com" <jithu.joseph@oss.qualcomm.com>,
 "clg@kaod.org" <clg@kaod.org>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX callback to
 fix trace reporting
Thread-Topic: [PATCH v1 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX
 callback to fix trace reporting
Thread-Index: AQHcqfRda5+Mn5Kj5UOjIHS9/+O4zA==
Date: Mon, 2 Mar 2026 03:26:31 +0000
Message-ID: <20260302032626.1974743-3-jamin_lin@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6791:EE_
x-ms-office365-filtering-correlation-id: 8ffc17b8-c452-4c8a-244b-08de780b7fb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: ehWsG2KvTCk9FE0Y/hdaFccNEAiC/9tj8T1hrpYMWt2aTo3Flz3y/e2xBPO0jNhddDr3BG3hgySrblcsa1yWrusmwgpmkurwaZKiua0SR8dGNVlK2M7QdcIG+yjsC7QWKX938ImfaAbg5d0zsvMbZzrfGharcbYoyEEo3ha/ZWXVHLEhK/WzJJrBtNdWsBF+KXva4Lpgorgv5gZfUkBn/Vz2lMOkvgUYi+6WVOxxdRHtC4XlKyH3Y5gHDbTmJnEE2y2wHyjqbg6fgKq/z+rlJ4fZik5UG7VfMm7do+Nl0Ih4dDdTgayAxxMkqHLdKptJmppV/ksAITQByImyhM3nJMQYNFxPjgJq4jsfCEiMjSL3dVRZxS5xyzj5MIfRAHW3ZXBK3pABK+FFC1f70+5pR5yPBZU+klG3n/G8jLVycH8z5j4SmDeqTXWkvYXOY0w2rvZg2XRZPdxFfU/SYmzYJKQT4/yIOmVov9TNQ1IFz3JTZnu4SxIzmcUqA2cYIYHfjpoZiNZPdYdToRtN2YJW+ZWCaeNW/DHrmOWq2MOkgiJcfZS7aqXopMpbnF/niciotm5bMoMjrQwz+HINbhSPVfKku+6Bn0+55dbtXgRUkTHmQO1Sr9mwynkzSSkSwRCPuFQh6PNtY4kRVJAWceIGUvyOgvVnyu5V3lhSR3WjbWDDuz3m5JCQcH8/eEZxTSMvfqHllS5UZMenSZ9kqe5LADamJ7JT7BbwBkcmzvO0z0y0vRMJR+7ffrfKihopJFxoRSRmVA9OdqPR/cH0CkrZhLyjZOSh2gAVXEg4mgFSW88=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pRLCP39b/ZB22WXrRkGsuVJPhUbfHuh0YeYpayYG6Ea1rcKliHhu3oiOJS17?=
 =?us-ascii?Q?f0IToOpEZWvdUujX+yRkivCKILfVPe/lsPKbMYPvi8lg74o48fLvWpPVbi5u?=
 =?us-ascii?Q?+xGr+1ReHFKIuDrCGCp7WedcgI1TL5Dgxrahg/tKAdcJBsgPfvm5ZvqL4UNq?=
 =?us-ascii?Q?s286f09Y057MDFM4xNsV1cz40dZevRCxaK0kGhcQzzYJHMwXyw4Q53EJBXLl?=
 =?us-ascii?Q?Y3FvxvrMl5qJSxgpKD5wEauSka3sN45hym2vD0lwhT/u45mNcRnSfpc06k2G?=
 =?us-ascii?Q?Cho9ACphH7WPLXuf+njPBJfdgZhpGShz2O6zvoECul1k46RslrbSgQA6yWPW?=
 =?us-ascii?Q?jc+J3EQlKgPddLZZe4NFa4j1xu2BLD7oyXk5X32nS58HtUknoYjXgI0QQ0e4?=
 =?us-ascii?Q?bNc9jw/gkygSrvfuXE6obrZt9gO0UEzpnBEtQFTiDe6EriGW9TmM4TUkYPDa?=
 =?us-ascii?Q?pVKy32yT2fxtQoUABTc0QNK1HbxqmageN+hNda41YbfMpK1Js1Cvp9gpZXkg?=
 =?us-ascii?Q?/vylaQ31ngN4unf6NxnFKuLeHAF3+TJBw0rDbU8njVPOVXqe8V6cHZRu8bJU?=
 =?us-ascii?Q?w5jw/vZ0w185OL+ReWjwkcphDLgSKFOWObT7uky9pgtKiC3eOMcSDW8lsVij?=
 =?us-ascii?Q?H3N6VaiSs2GACynIo0R40qUbae5ThcgES3XaHlOT9+KAiNCUUXCsUBD09JIe?=
 =?us-ascii?Q?06dLRWfx9fs0w30Qo+uYOUaZCkLjB5aXEEM4k9DexrpaMN7tTe+Ma6lzN6VT?=
 =?us-ascii?Q?JDU1WlpMAgbpVUBafHYQzoYjtt8seTuIdo81YJ71Wj7w3z3QqhdKU90XXL/i?=
 =?us-ascii?Q?E5J2Api48uMC3P3RJ1q9zDwTjK3cG9vKbS1yJEstLWM9YDpkN7UZDKguA+n2?=
 =?us-ascii?Q?3h6zRY08w4ZQOOIVqcchXqlP4ggUgzV6IhccOhhdz27FjXGdmMGvszJBtDmp?=
 =?us-ascii?Q?3/IfxXBOiJX3IF/5xCoBieqKBHEHEYym9Si4//+/CpL1Dahnfz8dDc9M/7n/?=
 =?us-ascii?Q?DzT/Jh+OxwbyYw4UobFPCg5RFg2Y8WSZEsLO2QLCE4fN7u6qHG5gsw5p8F/v?=
 =?us-ascii?Q?Uon2fCew4dQCTYuVeOIRHd/VjRYaJxYzf15GRRVIyWS7zIp6bnVn7koufM7K?=
 =?us-ascii?Q?9BrDQEmKg/thauz22prNeMicphz4vp3vGQ+ZUIzeXz301x60wC63dGetuYg0?=
 =?us-ascii?Q?6Hb/TWzHPN1QntD/ZR7dJs/K6el6PTwwRP6xFVrZjccirARBfMNxznedPMaJ?=
 =?us-ascii?Q?WMm2Aul9Cs0FCto/2eHv/Ci09fHEOHE2NZ6mXxR6ZkvA/Gc+agOLG7TYRmCf?=
 =?us-ascii?Q?Im6vIRgfv9JhoyYCkJP2Ljx/YrbaY16h1pVcCt1zGdd9h6ZRdl6Aa5iizFSn?=
 =?us-ascii?Q?ArtNlCYTTCVMNzFufGUDAkul1TA94D+XNhTfLbIIWvOdT4KN85LxoUJVEuue?=
 =?us-ascii?Q?yxJAeN9GHN4/RBQVfSXkYcAR5B0nkoYCxxEfs3IplPrdlP3xENhyfkHgjaPC?=
 =?us-ascii?Q?2YyyQUsf1BzKb7nq5/IBNSdziAZLIXswnzw3DgengkhlhcY/OhAo/LvG/gRC?=
 =?us-ascii?Q?whwqzpox0CFnBuv9h1rmbgaRT0Fw7gUC5OrLfAVhtlTKfX7e+P0S1sw7uDz0?=
 =?us-ascii?Q?l6usmxxzjTdCoZg1+McxLaybh+FOuVFqVF+iZ/0snKcxiFAqSI1LDSULTbE3?=
 =?us-ascii?Q?5Uf1TLDKdSUpiFrEMkg+HvlednyP9pEhtAe4tw05ZiVbK/c2Q6v2VN5hXNf3?=
 =?us-ascii?Q?u638NWibkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffc17b8-c452-4c8a-244b-08de780b7fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:26:31.5225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9r3iHNJx9BQR/KEMSp3NEeLZJ9reFWtxpy+VIG/Re/b3YGfbPBA1X4W/1eqcqEQ3Mnat7vrq3BxmbVraG3TkUxwa4kE7eobEINAwFRdDRxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6791
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

mock_i3c_target_tx() did not update *num_sent before returning.=0A=
=0A=
Although some callers may not directly use this value, i3c_send()=0A=
passes num_sent to trace_i3c_send(). If the target TX callback does=0A=
not initialize *num_sent, the trace output may report an incorrect=0A=
or uninitialized value, leading to confusing debugging information.=0A=
=0A=
For example, the following trace was observed:=0A=
=0A=
  mock_i3c_target_tx I3C mock target write 0x12=0A=
  i3c_send I3C send 0/1 bytes, ack=3D1    (expected 1/1 bytes)=0A=
=0A=
This happens because *num_sent was never set by the TX callback.=0A=
=0A=
Fix this by setting:=0A=
=0A=
  *num_sent =3D to_write;=0A=
=0A=
so that the actual number of transmitted bytes is correctly=0A=
propagated back to i3c_send() and reflected in trace output.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/mock-i3c-target.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
index 875cd7c7d0..5c913ee49b 100644=0A=
--- a/hw/i3c/mock-i3c-target.c=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -86,6 +86,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8=
_t *data,=0A=
         s->buf[s->p_buf] =3D data[i];=0A=
         s->p_buf++;=0A=
     }=0A=
+    *num_sent =3D to_write;=0A=
     return ret;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

