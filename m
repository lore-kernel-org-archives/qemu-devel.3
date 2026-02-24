Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9747CEFB805
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6H-0001hn-RK; Tue, 24 Feb 2026 00:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul67-0001bm-IB; Tue, 24 Feb 2026 00:36:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul64-0001I9-2F; Tue, 24 Feb 2026 00:36:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4Tp3MFIYnBxonOdXG1JJ384uoJ7MtyY/UiNKN0llzLJoAsv3d/v8J5qduvJ70amD0gg2cuA+U5DquCEbuubJZdC6/CwtPi+0BOfgMguAOcKAnyeqLQlQ3TK3/VQ9QEYayKSJVxM9HpgSR0Jz0OnRemawh12GIUMtjRL0/5hTyqqpw5XrdvZ4p4OGjfk2vJ6h3hU9bIByhtxhtnSeM9PsOMRmhbFZFZUgSlE8Jg7vpDhkJCsBzlsSP5uYjyfmJBwvhVfGvRr0dBasUHz6fnSfHwORPK1ONHv8yixgg5Fv6Cts60D+QNfcSUzrI8Se/tDSgWveqQztb+VuQUHuDSPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR1YkodCjzHBKGroe0DJUM7olLEYORn2iyAE7vug75s=;
 b=jVNbWEU5RRStAA79t//AWEBdIFk6TJ9B+AhZMO9cSp4rrivjOvjWLulqlMnhBWF+0mYLw9ggl/YEXSM0o5Gjp7bFmfMCHavWO7F1Q2+/H6YDeOULVnbpC7X4nwmE5VmacceYB8Kii/GSwu4NGU3SWrzBtynQwq+zPbTIffYmFiwWue1vxjcVxwY2UhMJPf56gZcmyo/qtZbasiM7TpWx9kSU3TpQ8+Vrbibd/vPXlsRoL8Ql4jiLzfxT6cURVv1qk/GW84deepNfVmsMTJwLw4nDpdbvb8YwewBJHgwt3WauQxTx6Jmk4iATgvSAziesuiVxHpdNr/31plGGpIRc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR1YkodCjzHBKGroe0DJUM7olLEYORn2iyAE7vug75s=;
 b=OyBDxlm7v5wRdu6ZNIDkNcFj9K+A1FcVXl/KX6KPd4LDGqWN/WsYvMYljRwHCroJkC/IgDNY2lBs6MqSDfosN91tmZxrDbZ9c0JmnnabchNehOneBCMQTmsFGj0nphoahX0dLApAocj9xHWBhNuxVB6LxFgtTzBxEpW0FtReUIn9iFNINUqWlhOVR9NAriYoDXBNP7kxlkCE1pqBbF7kHPygT1lwGBIA+y7taeICvXJm+aUjVoItyy/NDaRzqeyqoAmYmKgRlrum+WucItvl5mUU4tR+RJlAlfOU9tKB1U0SadbGQOf4hdFCs4xcHpyDP14cp/lxnP7Jk9W5TbVoMg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:26 +0000
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
 Venture <venture@google.com>
Subject: [PATCH v6 08/22] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Topic: [PATCH v6 08/22] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Index: AQHcpU+E95Unin5uQUaZpy6KTOf0nw==
Date: Tue, 24 Feb 2026 05:36:26 +0000
Message-ID: <20260224053613.589102-9-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 01d33ca5-bbea-451f-a092-08de7366a74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gr6KvJ1VRdbAybGiwJsmtNDgC3gvPeGxN4n7rLxpWp84WqLOQH4uJm8LLe?=
 =?iso-8859-1?Q?HP3/lS39pSjzfmWeItUzBTh4rxW2PF9qOjQC6PhOqDn/+JliUrwnRT0aSN?=
 =?iso-8859-1?Q?JH5+0rRZwyhJc0zgODgGNCTmPLXrRa0Ajo5e8/WPQ6cePSZU5KmMPsQ49m?=
 =?iso-8859-1?Q?RL4sI0qLvpW79rFqoaevpX/RgZsPdZjRKFP/UhfsmPAHUowk87TDM5sRsn?=
 =?iso-8859-1?Q?/YCflzyS8RvfnRtMQ12JhN+f/waXrHYdSlbQm37zxCNz64N9qYGgnil+Zw?=
 =?iso-8859-1?Q?k/hWu4rGSChJdXTfZ+BF7ORHKljP2LQPOcxQhqKFMxRab6gQ621ZA0iaIn?=
 =?iso-8859-1?Q?uY0zPgcIINBZs9ZZmDnlcX0vXAwWU6PI43+CiBYgNtth8KDClcsYic1cCQ?=
 =?iso-8859-1?Q?SLtbSpOfcBAhMXDHeELEG+RITmTvf4uZhObi5RYJVz7b1VXLCr0wRGCO5i?=
 =?iso-8859-1?Q?Bh4YAVDPNh0khHmRbDhRntktz7UgAFJv53EGCVPKZZ3v9dWhmAAlYe437T?=
 =?iso-8859-1?Q?53Wmbkhm37LsKBxeUxeRvYJcaibvgS3D9uyrRO+UVCXslAZYIBEHqeR/L1?=
 =?iso-8859-1?Q?pCOd5ACXFHJ5K4ShgjFvMo9ISMWvRPmyTTAQf3/YNEvkGCscMvsSpi9IE8?=
 =?iso-8859-1?Q?E4J0KH7bxHjVyhwaWY66d5h1vZVRxXpmPYIYgGhIaHzwwZKWjY9Z//dQZ2?=
 =?iso-8859-1?Q?h17+QRrVpH9YS+280HUj11/LMhzU6DqLA4jZ5ufPgu2643ZY5ArsXMGiG1?=
 =?iso-8859-1?Q?qPix8TO7MWmMcv4GTAF//yp0atNxKjkt/p7AkzYkdkpxuAMJRsQSZ2B6A3?=
 =?iso-8859-1?Q?V0NFIH6ZRI0hLC7tTOoJVr6Afy59rVqLws4KB72dvzgnuhnbWWuYOucn8v?=
 =?iso-8859-1?Q?IpO8bF+en7pTNkFUUGLs3qJwpSH0y2yr62zCky/fOJZeKpkwd7qipX+byL?=
 =?iso-8859-1?Q?Sosdu7S5W5sD02a8KVIFtYVV2/vuNmDTBCmWM9p3ptOy8N3MSVsc17wpB3?=
 =?iso-8859-1?Q?G2QOd1i3OAi+TbJ/DDhrPcpdWXTdgFI4Kq/j+Db0kKSq89ieWT6EGfuPvH?=
 =?iso-8859-1?Q?YRtJvb6zBO5NvqOaXhs2lCdj2vD7+g+7uXqdLa56Zs9F2vsZPlc5lqpw2s?=
 =?iso-8859-1?Q?pTxObQmgSZYqdz1aBB6blfRcxUqCOL3zU+6883GZ3OB25uQ94xGZ/WCPv4?=
 =?iso-8859-1?Q?7Ldw6BkY+Qw5B3qCIaa08fmr/riQ3JfWeT+8n19+CmGUsFs9Hx9NhMFOI0?=
 =?iso-8859-1?Q?lQzl5b1imEW8mo+0f0Sx/HeEV/rKZm0FM4VAgxYFsZ5JMhib78wLW1R4ac?=
 =?iso-8859-1?Q?Mlytu5NsEHZ/77/YAv27yAebbuNgqc/orXw2KFzEUdRDTD402wpYBeCwtg?=
 =?iso-8859-1?Q?4RnHx33APvZj7oajhUEZSR171m+TFvcS75EqWQ211rvhTOeyzxkzwzwdiA?=
 =?iso-8859-1?Q?WMtzljBhAcIRstIrew5IdmtN6sRqfMPxvuL5qbeiMvSyj+U0jjvNC9jusM?=
 =?iso-8859-1?Q?WTmdJUmAUWycOn9CMB+2bNFElVbEYRlj7GmCQefWOUDLfQBJTQqe8Y7Wyv?=
 =?iso-8859-1?Q?syyv44t920+BzDBU+r/PbWaWWAKabDlYggO0QM1Ud3l7EwZhG3ujc9H5iz?=
 =?iso-8859-1?Q?dON6rn/5QcAC26OCD702eA63RusuZ54ft9Y6ffPyNI3ybXrkzfTbHt9A7x?=
 =?iso-8859-1?Q?3bMJbreVtQnNseX73HLvzge+1TKCTAy422mZmauY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M4XooCStoD/k7GjCP3L57cNDxPDG1qQ8qrH7Gh1Et02QTdrwzGDZiutWZ/?=
 =?iso-8859-1?Q?5Ujukv/hG8HTfocYKA3tUnvqO/0zhOY4hkQ22LZy/e4fBf1AShCKSXwopf?=
 =?iso-8859-1?Q?YrAb0qIcP608tlOydYDgkMQJI/KuawUBL54atDOhC+ZKNfaxpKCDik9gvj?=
 =?iso-8859-1?Q?TZmVH3S9x7sGrF5HLA0E7N9naz9mpJ1Hrw916BLOOxKN96VUycs5fu3/Ck?=
 =?iso-8859-1?Q?Ey6GrI3LyVmJhjYCjQu5E26pNRBzDMsuv8XbybNyd8faVOCYn6+ghfs18p?=
 =?iso-8859-1?Q?KH0ua5WCUslA9DrvuJMzafnemlcvMZQz77Gqx2fP7Ja5H26BAEuubE8Ccv?=
 =?iso-8859-1?Q?rHg6sbXXROQOnBiZ9zpV78IkMkkaCAbswYIpO/aJOryi0HTeK0KoGCH4h8?=
 =?iso-8859-1?Q?0AQchrzxovAaKl/b/w3umYRC9i01pJOi7XOuv9K9JPjRzos6Iub1T7y8EO?=
 =?iso-8859-1?Q?F/4M6gyUW6kfwEhRIT9P//0OucngDH+En1mjNVMpINVhSmK47x7rp0vwhP?=
 =?iso-8859-1?Q?oFfiusJxcT7pp1yXqKELFx78f1Ol6jSEflZu1NvhNXjBj7qftknvLHIeQv?=
 =?iso-8859-1?Q?XplbySryjPucrpIPijyjlZfxUvqwxITY+Ajq70FdD4J5J9r3HXpr9lsKqe?=
 =?iso-8859-1?Q?Uk8y1vUpt9lrVOyxgmdaqEuDL7WGrp/NrER3cme8qNNYdgn1LZwSD/J6a7?=
 =?iso-8859-1?Q?UpGWKzLW9vuMBwzpmf9NPXJu9BVaFI9Ix4NAU/w8HTppJE+Qj6pMDOxqwo?=
 =?iso-8859-1?Q?/ux3Z9oz6GhJENx3q8JQT0vyx2ZM7LBn9KQIzb5Qzpq3P1G3vCdLbJxPNQ?=
 =?iso-8859-1?Q?2oNDzHj+6/pVJnGAqohbncsU7eVvQnIFqlM9J1ONihJ50LUc+VF1TLKPzQ?=
 =?iso-8859-1?Q?ffCYSLGOR7RIPC9VXHR8J4a/pW4tLAytFKbKEKTeK/69ac/tr9CHASI3l+?=
 =?iso-8859-1?Q?WCaCrO+41BVRACmdGTtJhVrKJVkwtq8OifLmCobWH52Tg9m+UbqErFQx3h?=
 =?iso-8859-1?Q?Mvju5WpEaFBoCw1L3NBbB1w1LAGUACQ3IsY/xvijwEq36UjzNRvDwwYoaE?=
 =?iso-8859-1?Q?ahFW4hdgqqI0lVCwBqbkhSZmrg1mQF4dUTvUBYFUGy/ZTsgso04qQxcDfy?=
 =?iso-8859-1?Q?A1D7CsqHfIVukArYFvmktx9AtUbfUJ60eCHlhzrEXBmfxGXQZ/wGe3bUGc?=
 =?iso-8859-1?Q?NFHBTpMtCRbv9W61mYL2/eN3kCssp8SmBjOW8x2EV1iUCQhDPC+ORwe+o/?=
 =?iso-8859-1?Q?ahiynUTii2VAFtXW5KkeNhJlNRIg3U+5qKcl3eU9xCoqbys7WJygRbM8oh?=
 =?iso-8859-1?Q?SJ6+m/3r+WT6r2mTjR2hbIS1x8+l+Gm7vj2gQkGgQxo5oQsrWmF0IAhgeq?=
 =?iso-8859-1?Q?qYuOvCL/3BZw5NiDocZTgkDjb1vu5WE3lJ5okDgcTKis3ZV2c46g6PUt+0?=
 =?iso-8859-1?Q?PORe9wyIrcFP+JJPDYNxirr83KQGmKwiXRUbXpGaDiOTiqwSt86JiDeBDn?=
 =?iso-8859-1?Q?VkkEJq28HRUY7c9m4MGI1sZr/IGFv+UAiruZxBaz0c25/l0xtZSex94VLC?=
 =?iso-8859-1?Q?wb4+FvQkfJ9uAiiSzy+b049AVog2apmWCGvk/274Z4LSpV2gejoXvG7RGh?=
 =?iso-8859-1?Q?zBn7HT0PR6Xre9NkP2f8A1IYmGqWqa+VqGtEUCxCZBUGRowwhvZ5ofptSm?=
 =?iso-8859-1?Q?Yq1cdq3VuhNe/V5FSV8bjE5AXsdWA2AwY7KYruUkibzoFORfVpcab5aOG6?=
 =?iso-8859-1?Q?YVPhnOptivbwa5Al3g5W+hW6UyFHXdnt/ZZ8Jk7mJ/4Tzp7HhfuNa/7K/N?=
 =?iso-8859-1?Q?q0oh9Vvi/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d33ca5-bbea-451f-a092-08de7366a74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:26.3933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TS9wv0jdbQ861PR6/EcZuEYxFQVNunoaBfNT1aBgGDenLCZNXaoig3o5N/tnJ9h8DxuVwmxq2jgLV9rvaUzf31mPbLowRI6tA+WH/BIsJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Adds read-only register masks for the Aspeed I3C controller registers.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++=0A=
 1 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index a215700288..2700c5f4cd 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -74,6 +74,21 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
     FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
+static const uint32_t ast2600_i3c_controller_ro[ASPEED_I3C_NR_REGS] =3D {=
=0A=
+    [R_I3C1_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C1_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C2_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C2_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C3_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C3_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C4_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C4_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C5_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C5_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C6_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C6_REG1]                   =3D 0xfff00000,=0A=
+};=0A=
+=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -97,6 +112,7 @@ static void aspeed_i3c_write(void *opaque,=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
+    data &=3D ~ast2600_i3c_controller_ro[addr];=0A=
     /* I3C controller register */=0A=
     switch (addr) {=0A=
     case R_I3C1_REG1:=0A=
-- =0A=
2.43.0=0A=

