Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B5EFB806
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6B-0001eH-So; Tue, 24 Feb 2026 00:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul60-0001au-O5; Tue, 24 Feb 2026 00:36:33 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul5y-0001Hd-4o; Tue, 24 Feb 2026 00:36:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BykoqCZ4dRcSCL0pV3XS7B6B9pHe+GJtxq3p9d7ndGxy7r0L0tATBU7lrErIWs6RUH9n6b3hQ8g3zlX4FBk7rvvp5Pz8EHbsyaP8K2UrRtq2T9T7xRhlzXtvOzkyeHZKmDnRF4f8Jm92y8Kh74gO3XjvSSLHxo/0rzc9jaulNnAO9sitv0erI1tSXuqhFNApPEUhNGLRtOjW1E8KKL/S733bGW+CMMHsFjRUYR9P5z6Gp8acVO8Rztyc2V9LBOtzSKuei5Tt9k4s6C0uiz06Lk/+4ENT66DgFoGMDHd47Z0L09thi8l8X+ajQ6HrcYUZzk28P8DUziDo1ChhuRkVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znLJTTXOnrV4vAr/FdrJeMBRQ5ZZDcp9pvGohSa33Y8=;
 b=bRZIhobxfFn+GZnjkqcF+DojlwnVCfVjem9OJD3h1jwDboppxcWCM+tIfL3D2wSdEOPHuMeDIka5UNLHhuAkTGsvtcFONQ5v1/qpH+4c42o60XrZhCoZYrjrutMltlBMWACQ8pfPik/8DGO+Gw6I4UtXE59QOYBMAJ3hzSG2qOIH8L1ufkEPQjh1Kzx1JUEndj8TX2nDQDyQtAh9Kffu9ThErdOWUsIFxavzq+DoFMh9Zk7Qn5j/wQ0P+G+7WIy/nfBEhhBJjJ38VNF9x1fJxPdTY/4elMLFbrl7hxqW9z5luIXHPM67UlCXgseQACK/zvd3GgOq3L2PegRlE4jV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znLJTTXOnrV4vAr/FdrJeMBRQ5ZZDcp9pvGohSa33Y8=;
 b=Ht6XoQJsLToWQiHwj0hJkGHKTfvrrX2jF6DXog8d+rrGo7q14gfGLyJxYs5UbFM2ZTFZFvEpMhbmp0BYpW+5N+EBhpkno07R+a40nhaYIL7ys9IIRmyrutBC2xiQ5o8DcYcy1Kb3jLlbdTUgqiGP0Sr0L1gtH+iWOzXXn81LmCceDf31vpv/eGWQxW/pyKTKo832CU9f/+z0gQg+hka7Mer3JKA6MBHAYw7R5v/OQmT6xxQJOegAY4pDyjUbFR0ZnUYU7+63dh8s0E3zIaKYRWeQ39PWdUxc06R7pHiBL98qpaV43mEjJeL74kyITJtIy7ccXM950hLUKCO3+LI0Vw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:16 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Titus Rwantare <titusr@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v6 01/22] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Topic: [PATCH v6 01/22] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Index: AQHcpU9+VOJf67/dLUqabY3vtPyuCw==
Date: Tue, 24 Feb 2026 05:36:16 +0000
Message-ID: <20260224053613.589102-2-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: ed2abc65-34ea-45db-6e62-08de7366a130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?I1eO3JwyCm/rubqdLw0+Txfnz2HJrJu4+llowS8XWRe1L6kqXsOWPbZEaM?=
 =?iso-8859-1?Q?GkfkEEbMMxfHJUOPmMEkn4nD5ilqD8+Zyx3i/j3Kaorads0cvbn50nF6dT?=
 =?iso-8859-1?Q?c9APSwFu/tJZNjmKI0A2QX7pF6BRt1jyHoGH0VVrgGp4FfTnZEFHLSO5mt?=
 =?iso-8859-1?Q?p/Mv7NS4keoKNd/1qB4257/k6EnPlLyrMYXZWasUcTWP7u8Q0LPYxB4pcu?=
 =?iso-8859-1?Q?mzRcsroeToCDFOA5J+J1ZLqWq1W576Pe8YY7KCpS0NJc/yjwTgwE0Uc6k1?=
 =?iso-8859-1?Q?GlErHQ+SL528v86cT0ses2QNAAvmfoW2uImvvFKuWwWsVZyAUY/suPfh4v?=
 =?iso-8859-1?Q?ceVqYpeVeUxqEu433LMFoNGYKb6Be/Uy/CCIG415/5xHDW99QK0HxSPolS?=
 =?iso-8859-1?Q?kkF6fB0eVP2RQ8/5xSdQ1JDJi9z4sRUfrkTNOZap+jx2AU5mJ8+Lf6xcgz?=
 =?iso-8859-1?Q?uufl/9JZt5MSRhQx71yu7lJ519pL0q7qY2v8KIgJI5N+GMeIF40sUVGvBT?=
 =?iso-8859-1?Q?amJofCW/evU1CWBLfMyMrSaiVv1xnJqvepUALHWjPRMULqxljuJTV5ES2d?=
 =?iso-8859-1?Q?YJYqKWzlXHgv8grGwMeE6T9OUPafZoVVh5TStPFrC1Mg8hv6gNZKKjDSpK?=
 =?iso-8859-1?Q?GPRiyXhfZJqsjRy3EJr69L4C+F+7qHe8ZdkNhNfTkcCb1zIQBZJcofCyU8?=
 =?iso-8859-1?Q?NhxueyAEgEF0R9aWlW7SjB0wEtedkDmM01/exdUdtyMEyG6i0NeGSgYtyZ?=
 =?iso-8859-1?Q?EIu+/vSi3mxF4wd4x6Ma6DwJsw5g3pH3TnwcWyC4ZFf6KGzff3kYUY15DE?=
 =?iso-8859-1?Q?9uaFwh4inHWL2mZ5nmgPpWULe7cyGWuDpeH/vROw3+3VdJubIOX1b32W9z?=
 =?iso-8859-1?Q?01MQEiY0N1QZ3hA/pfvwfT0sB1OyCu1djVoFurmHUZ6xkMvmzHExvertzh?=
 =?iso-8859-1?Q?Z8Q6NE+bRD3OWqPWXIFTQoyvN5nYT6UXWGAPm1kEZPqRDYOxaZ4CuYH2CV?=
 =?iso-8859-1?Q?s7eMoQjdMRbeuwO96CUtJgP3Ru3x6feWuEGHLqisQkmAfniisyzJL0Ikw1?=
 =?iso-8859-1?Q?CBoTvkVVK9FwV1PdwcB4asCDwv1/0kmOmbqCfmWkLEhVEVdu1jRrFlvqsw?=
 =?iso-8859-1?Q?XTV9qEbbvAedmEqQWaAn/Feg64vafIriLcuktBzhmfc+Ybbx1WW65025/A?=
 =?iso-8859-1?Q?FGR9GHEgNHlfv2Ug+OPpU6nPXIYtgeRoJw0cFJUgqfFREw4lSRYDJDIvXi?=
 =?iso-8859-1?Q?x+20itWN8OiA4PaaI6uRv67LNOBstDfAXqt7id+pCUC2XqI2KLFAFrWFXH?=
 =?iso-8859-1?Q?Td3v5NBlVJkSWpI/N4ziGYkvGyRX/j9i+9hkZwqKFwpg7JRzOP7aMWWid9?=
 =?iso-8859-1?Q?y9OmKcWXMQSr/sX3ijP67ECAe/JBMws3/fuz6C8ShWEJkEdF2AwFu73m1f?=
 =?iso-8859-1?Q?lLXxUcJK28WzkgV4eL/51Cz5iYRQsfA9sgoX7KZYVTW7iVdYT/NLoLsHtX?=
 =?iso-8859-1?Q?yuLPKtEF3ubnG4Rgth7GPj5p66udL8kum1pwNSmVrIaICkEaS87lD5KFhY?=
 =?iso-8859-1?Q?pTJPKS6isPOKNs4j8606pMUFBX3HlGq7/ydCoglT3VxX9yZ/KeiwAy6wL0?=
 =?iso-8859-1?Q?NFyO/etXa4BL2cFnS0EaSbxEIJ8RuS93EcSNAA0rFBooxx726XWoZe2W1X?=
 =?iso-8859-1?Q?lbBqsQO0Egp19QrDl+TktKi6Y3WBjgBJRPzxvp5a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jz0EzYscfOAUqI5ieopVzXC0TUrvFyvn0tSO/Tq8v+WACQuX5vSGOvNDhc?=
 =?iso-8859-1?Q?V+VFzjVQusdQ6n/JXP0Px8xLt75ECuPJ4BBPqJhJUHVVyREtrmfWoBNcZN?=
 =?iso-8859-1?Q?W6avA/onne7VXi4kmxMSJT21apuKYXe2wr7TSoeHrmMbnzEgwFERcSS91g?=
 =?iso-8859-1?Q?PJkM9vyFN5RthH+iJBemTHQA+2Kuzkqvnqjqw/WXhYF1PyPAgO8JbQqeH+?=
 =?iso-8859-1?Q?xbgW2JtsKWIdF6FKBiq7c8m0u24tSm4o+Dx8PBcSx77JQd6dZ0nt7GaIf9?=
 =?iso-8859-1?Q?4O0QVMUgMda216xj8+fj+GNJyg38f0YnkEeuLR/cnpFVW4f0oQDc0PpMka?=
 =?iso-8859-1?Q?tCk5MmHX84C1Yka22rba8ULwok8Kqw6YJVuyDxkc/TX8jIoxH11rVho6CI?=
 =?iso-8859-1?Q?/ndpZZtsv0p5fEeHZD3SUaQYRglYcIE9ZxHjENxJB/ZpPQ97HN318RNAOM?=
 =?iso-8859-1?Q?29LwUH3WUVn8U3HDcMK3DJryqYYaIifMwAsnmHK3KMRXhGHg0/l/qhdLjW?=
 =?iso-8859-1?Q?GVjf9/E8IfMAxZvIenYzGQbaQ8f+8oeGkrm7NCsH5bWzW4QTBpUXrElClP?=
 =?iso-8859-1?Q?y4mwHrsRmzhPQWhxLm3H1AP0gdrs0co6pJHR+O8CuD0GshWicS8+Jmh1Np?=
 =?iso-8859-1?Q?Or9ioEM/K4KDC1UDmsHiXwttHbpnj1Z7rL9vD/0zzb50ABpxy1La5RimAJ?=
 =?iso-8859-1?Q?5NFqT8acVO459PHOViVSg86Waf43KSaYBYR6rKzfLVZ1TknqVd7VAu06C5?=
 =?iso-8859-1?Q?hwBbpVR5vUUjMqcvsnraRdkWasDB8qODGdSvQ5NvJBAwRnCPUPAVEZo/eF?=
 =?iso-8859-1?Q?y28YgyjJzxJMo47h6k/GeaD2tlrb0AISuaSYAh9pRcuuS0mtnwLEe3i5oS?=
 =?iso-8859-1?Q?r1f7Whxemyas1gebJ5iRAuRvgF++teRmq6Ux/To1UOt3lyz5/eQEMhj7JO?=
 =?iso-8859-1?Q?6nMpF7AcDSB0SPHlTwQfEgg8I+bhuRTDj197TgiUVQ/c5tzMTnfYjjtCe1?=
 =?iso-8859-1?Q?8VhU5Qt62Zzk6L+EIN6nI/qxlzkCZ0pYAwrdg47mb0MdPIuuQNAj2n/rQx?=
 =?iso-8859-1?Q?/N11Ivd9RU/YOc605q+NSs/rXXqiGU3XFlivJx/ddbRfuXD0PBLduFjXZZ?=
 =?iso-8859-1?Q?rPyuThhUfCr4Bp1xTWQzrz6E+jXlO2+qx4s4PNHPKN9Dusfd2b+ympal2s?=
 =?iso-8859-1?Q?zK68RU591yTrbx4IkOMnHrCfP+L3XUHEwqGCiEqXPPEoyv5WBQhVM5TGWJ?=
 =?iso-8859-1?Q?NISyogOOeipneQkpmKr6znbNr8rL9dLklV2ZSVrPdkSSOypbKOBk3Ip19P?=
 =?iso-8859-1?Q?/xp4TO47e4AY6fY7mWFvKJhksO4w/nSN7U2jBu1byoUTFHChTLtMeu03NK?=
 =?iso-8859-1?Q?YafavZqEfy+/6w114oHfbuAigM/oafkeuGuuHZzv2uNc8Q+UgHE9XWIpDw?=
 =?iso-8859-1?Q?AYtfAedeE6i9Z1dOuk445iOZad3EdGxC4bk7iqqbM7zgQ41N81VDrckT3F?=
 =?iso-8859-1?Q?DxVVL0I45egJYf2c3tbNPnrjKlV8gFxqNSqjp6BPSr2TEOPuGW6rmebOXj?=
 =?iso-8859-1?Q?7CZypV1zXwk21nNqknJsQdxwMnind8LDReKq2XoMPAi/YR5GlxwJXYxfmJ?=
 =?iso-8859-1?Q?EeVrcRa5+J1RNO+FPXCoTOD2Li3oI/7l8Rm9gc1yVw5Sp7a2ouPgP6v+kM?=
 =?iso-8859-1?Q?Xm27bf8VtfSvfsx8Dh495BWJXXR/cwfB2OjomlOH+TGyf+1kVRglXglDur?=
 =?iso-8859-1?Q?KdeQ4FPQV/iVeZyQcpf++GGeT06X4YtR0yX+ojI7TkI1b7xWYcAHg2/2Kf?=
 =?iso-8859-1?Q?G+fspnknag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2abc65-34ea-45db-6e62-08de7366a130
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:16.0806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4PkeUcH6RPmfNdTsF65INWwLR2LgV5lt+ar0byomnkUr67pSB20upL5ejvQBbRTsQMnMFMGgywFBRbf2IAZVUCZgyESywfonh0GrTNbRAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
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

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build=0A=
files.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 meson.build                           | 1 +=0A=
 hw/i3c/trace.h                        | 2 ++=0A=
 include/hw/arm/aspeed_soc.h           | 2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h | 0=0A=
 hw/{misc =3D> i3c}/aspeed_i3c.c         | 2 +-=0A=
 hw/Kconfig                            | 1 +=0A=
 hw/arm/Kconfig                        | 1 +=0A=
 hw/i3c/Kconfig                        | 2 ++=0A=
 hw/i3c/meson.build                    | 3 +++=0A=
 hw/i3c/trace-events                   | 7 +++++++=0A=
 hw/meson.build                        | 1 +=0A=
 hw/misc/meson.build                   | 1 -=0A=
 hw/misc/trace-events                  | 6 ------=0A=
 13 files changed, 20 insertions(+), 9 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (100%)=0A=
 rename hw/{misc =3D> i3c}/aspeed_i3c.c (99%)=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
diff --git a/meson.build b/meson.build=0A=
index 414c8ea7e2..41c5e2ebea 100644=0A=
--- a/meson.build=0A=
+++ b/meson.build=0A=
@@ -3610,6 +3610,7 @@ if have_system=0A=
     'hw/fsi',=0A=
     'hw/hyperv',=0A=
     'hw/i2c',=0A=
+    'hw/i3c',=0A=
     'hw/i386',=0A=
     'hw/i386/xen',=0A=
     'hw/i386/kvm',=0A=
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h=0A=
new file mode 100644=0A=
index 0000000000..1e0c4eadf0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace.h=0A=
@@ -0,0 +1,2 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
+#include "trace/trace-hw_i3c.h"=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b185b04186..d7b3647ca1 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -23,7 +23,7 @@=0A=
 #include "hw/timer/aspeed_timer.h"=0A=
 #include "hw/rtc/aspeed_rtc.h"=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
similarity index 100%=0A=
rename from include/hw/misc/aspeed_i3c.h=0A=
rename to include/hw/i3c/aspeed_i3c.h=0A=
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
similarity index 99%=0A=
rename from hw/misc/aspeed_i3c.c=0A=
rename to hw/i3c/aspeed_i3c.c=0A=
index ac6db214ee..fff259ff66 100644=0A=
--- a/hw/misc/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -10,7 +10,7 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
 #include "qemu/error-report.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/core/registerfields.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "qapi/error.h"=0A=
diff --git a/hw/Kconfig b/hw/Kconfig=0A=
index f8f92b5d03..1b17b7b446 100644=0A=
--- a/hw/Kconfig=0A=
+++ b/hw/Kconfig=0A=
@@ -13,6 +13,7 @@ source fsi/Kconfig=0A=
 source gpio/Kconfig=0A=
 source hyperv/Kconfig=0A=
 source i2c/Kconfig=0A=
+source i3c/Kconfig=0A=
 source ide/Kconfig=0A=
 source input/Kconfig=0A=
 source intc/Kconfig=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index c66c452737..8344b9769f 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -545,6 +545,7 @@ config ASPEED_SOC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
+    select I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
new file mode 100644=0A=
index 0000000000..e07fe445c6=0A=
--- /dev/null=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -0,0 +1,2 @@=0A=
+config I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
new file mode 100644=0A=
index 0000000000..ebf20325cb=0A=
--- /dev/null=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -0,0 +1,3 @@=0A=
+i3c_ss =3D ss.source_set()=0A=
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
new file mode 100644=0A=
index 0000000000..3ead84eb45=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -0,0 +1,7 @@=0A=
+# See docs/devel/tracing.rst for syntax documentation.=0A=
+=0A=
+# aspeed_i3c.c=0A=
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
diff --git a/hw/meson.build b/hw/meson.build=0A=
index 66e46b8090..91552a646d 100644=0A=
--- a/hw/meson.build=0A=
+++ b/hw/meson.build=0A=
@@ -35,6 +35,7 @@ subdir('dma')=0A=
 subdir('gpio')=0A=
 subdir('hyperv')=0A=
 subdir('i2c')=0A=
+subdir('i3c')=0A=
 subdir('ide')=0A=
 subdir('input')=0A=
 subdir('intc')=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index d304a98498..96b6705b7d 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -135,7 +135,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: fil=
es('pvpanic-mmio.c'))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_hace.c',=0A=
-  'aspeed_i3c.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
   'aspeed_pwm.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index d6af2fcf85..b88accc437 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -293,12 +293,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsig=
ned size) "SSE-200 MHU wri=0A=
 # aspeed_xdma.c=0A=
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%"=
 PRIx64 " data 0x%" PRIx64=0A=
 =0A=
-# aspeed_i3c.c=0A=
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-=0A=
 # aspeed_pwm.c=0A=
 aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 =
" data 0x%" PRIx64=0A=
 aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx6=
4 " data 0x%" PRIx64=0A=
-- =0A=
2.43.0=0A=

