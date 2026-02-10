Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33319EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlo-0001Eq-Bv; Tue, 10 Feb 2026 04:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjle-00018I-0M; Tue, 10 Feb 2026 04:10:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjla-0004ip-7u; Tue, 10 Feb 2026 04:10:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8ulFWT85rSabm165dtR2mWH9pOQpJ6h6eHoATc5ASJ/sCVWijeDSylexze/bRVGeGRHZGp3ac5FQCDzoGDpC59q/faKdiXJOI30sI2GI8QNVMKmKjQEomYD1hhcNg8qK6rLHGbvdkgvS3wZ8QK6BQEv/KvqRxgz5ZjrUzRPMMctnWlQYYamwTToiHfX3RjaDpVXCp1MiNXCmqGdSpckpPNi6GCeiVbbmY9nsojpgsyh+hhQghJVceRrYt5o4FYrl2VKR7c9Vq0cewVln34endYtNhuA6V5H56fKsfZwy2ckf3TxRJGpnEgTnOhozaqomBL4m1bfDVD3HPQZH1snLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNJGnvv7T716ktIxUUvnlNKynsTuSSmaB6lUz0Q6bU0=;
 b=UG71Z6FPIg5X4gNYx53cESL+nyj3FyviJhcb7IEXaY0EvfdVDiWfmmE1BAr7oJ2/Khhf0PvjJ6bn7pu0MU47tIgjHjZ8Hmh64dRY0dx9hthKTYsUNSYlX/4zPW7bu09+ciyvI1S0ENBsswgMJcxWpdQe32l81XzTMRWwpfPPFmacDVT3ULVOFEI7WtimdMM7ELC1ygrtdjN6GO7xHdfcM24sEaVec+s9QNbmPdZ+ec1fpHBCComYqurQuePJ1XPfDq0zm8qIPy5JeSNmxn1a5frrnaNGrPVnulp9Nkr4VEKATlGjtxdjZs8hC6U6WMzqHakRvjqjCd6QN3XfhVD+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNJGnvv7T716ktIxUUvnlNKynsTuSSmaB6lUz0Q6bU0=;
 b=aYC+SQFy00H5HRypgSeWD7DXUHuemYZMy0ulVd9yED+F8pdsP4GFk2zSfKIYgAnrJlKYEhDHHVQMjSlbBsUOpk2aIGxeIfbQxMMyNfIDCZiq6LnYgbwrKksRkB+qEV3+jmjwWEAwrPShmwybc73ftqZ7Y33hVmKI3TFtselmJcO1TPNuQTyHOq/iQ1AzQFkvC+UOvX6O+I39MJ7TcR5goLnM4bm4mK011FTP+lVSo2J9UY593xa02M+Ap5T6C3PUDgltUJfdSNuvU18SrJo5HsSh+PM0cAfGjU+St9wawEEmjHO8HMtPZjemaEcUWE6laqqQxLxK5vA7Z0SkpAJoNA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5264.apcprd06.prod.outlook.com (2603:1096:4:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:22 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Titus Rwantare <titusr@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 01/21] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Topic: [PATCH v5 01/21] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Index: AQHcmm0V0FQ1Q7fe7E6OkEWQ93tA5Q==
Date: Tue, 10 Feb 2026 09:10:21 +0000
Message-ID: <20260210091018.1553489-2-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5264:EE_
x-ms-office365-filtering-correlation-id: 3374e4b5-5177-4001-2b93-08de68843899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sqphzuDZTeM1kLWw9+B/iAasU3a5/MAm+ARyH/SYPn2dxDcVic1ZmW6Pg3?=
 =?iso-8859-1?Q?vFu1mqzjSM4EzEpWlnD0EaCGZPvVhe78Bu2qYT9IICVzhtblq1z6iJ+m/o?=
 =?iso-8859-1?Q?AH5zCcpFE/dFqNY/LVrwHJn3adpGvS+cQZGAVHsYt3yiPa08QOwpiMO5of?=
 =?iso-8859-1?Q?tAEsDMWwyGp4eyxYNkxZzok0Wg2PLuZNv9jMDMZPRFjFkN/LeUzVKgyjwb?=
 =?iso-8859-1?Q?V7ZOmwHhFNlEGOAblmTf40EdBEWsLZYFeS+8QkFJLzUDkbawi0c7Du4cHB?=
 =?iso-8859-1?Q?/DoF9A+m8Ibg+fVhP9jvYdfhR+s0od9E8t1DrxiyUz4XQ7qO1u8SVkBaF3?=
 =?iso-8859-1?Q?TNp/OGFSCtU09MSLJSLeyyWweCJZy8chOl3DQAl9z1lltWBmFA7K4ig+4e?=
 =?iso-8859-1?Q?RR8pDMWpOVrutNMZJPzV0vJgWbRL3G0kDpFBPffAMcplzHdiAOCXeKaud6?=
 =?iso-8859-1?Q?gw2tpJNRESLf/jdue/182DQ/4uHgRLS8rr7MzDhiX0pFn9SkfYxblYOYFo?=
 =?iso-8859-1?Q?PHRrOKHSyoDqY66Z65s91C0RJv71GghI1P9yMJ48OejLjMXEO89A4o1qpA?=
 =?iso-8859-1?Q?StKSFUV3zug5jLpjCAOOEWtzlapeTazQqyY8dw5qKpNdUIZc+rxBwObI2r?=
 =?iso-8859-1?Q?bOHZ+VEKZXWAh67co0pDPmtrxFjaDNGovwfbDMearKonLU6V+p4x2HdNjK?=
 =?iso-8859-1?Q?wDxvhizuHVZWcjwagjCLycj3qp7IaMkp/6UuhhPv9nbgXtM57jGLpl8nUv?=
 =?iso-8859-1?Q?oBOT3CiUAoOKj2oMaClQ1wYCmH/TsrrIU64shDSX2GsPMZFHDwt3tV/2/4?=
 =?iso-8859-1?Q?SRFR/EZoSQLyZUCFI6DjusK6BiWJd8sqx9+loa7R4WQ/7oeX7HSGtqz6X6?=
 =?iso-8859-1?Q?DWy99SgtG2QDetv8okjQv2yR1LUV2wuUwHicLGE3Q1sAvOdCtDCabpUDvn?=
 =?iso-8859-1?Q?IDUqEPuiQVuTmKBcz2sB0NbqHKfaUDMWWm3l1HNwm2v5J82QCpWXqiSSAr?=
 =?iso-8859-1?Q?090WTiJPN7GE9IuQpkgEmqKNrp4b7TWEfWFEoqzlR7mmj6g/3r9px+ds7h?=
 =?iso-8859-1?Q?OGT75AjXUZmsZgfwNiRgPnzPGdUER4PaNui9AXAV9ClQXOk+cTnSdV99kF?=
 =?iso-8859-1?Q?lhy3rx8Uy/zxhtcqerl4iojeM3gA+gizsOLN/gnRNKln1I27YHAXzd/Xjx?=
 =?iso-8859-1?Q?zZjdqNy3/yPXWEqUBITaEL2E2bENiN31AzOg1Ek9al2FlCdMiX0DM4zUcA?=
 =?iso-8859-1?Q?OrqlRRB1VkgHafsLZQTrHTilNpi8YYEvo8HdhQpL5yiowL5Y0GxGq9S2yf?=
 =?iso-8859-1?Q?vZRXIxKloPs89wxdkzu/xbTgkicratXOsoOdHoYr/K9LEladO2S06HcpWV?=
 =?iso-8859-1?Q?q2mSEOZO4Y5d8wHs2QYnyNA+QTWLkh/4oIz6yw+Ny1lZixbeJzaS/AkRQ2?=
 =?iso-8859-1?Q?QVa/tkUhqIgNYZpN1jAbOvy22lsOkZkXboMVCJWy/9br80jMKwFyMkH2XE?=
 =?iso-8859-1?Q?CIWm2PmB1P308dCXWjl6yPXI1IpEFyfWOdI4fAPQXJY4A0FJ2EaUbmtU9J?=
 =?iso-8859-1?Q?Ip9KRFbzbb6NEcEU+5axdckSynDp+kDeohZN/3M0kEDFA2XfB3AJ5jBGlg?=
 =?iso-8859-1?Q?BSBA1gDV6WDfTh627EpES3VhTObw7GL2x9W5qrZHEfTT2itjItvR9RwrJq?=
 =?iso-8859-1?Q?s5dNpw3+wUEq7bc9bDjrgfXHscg6Eb3JzMKTeDQc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rxuYtdka6b8zInd7iTJlGMTCMJoizIdsSLIbGf6/wk3Ovspbb9K5EfXL5W?=
 =?iso-8859-1?Q?r/ZkDEtDQLq4N1tLvOF3LTZ5drw8gEpF61LbXbxcm87n+VSrJpGJvjbNkc?=
 =?iso-8859-1?Q?MGYZ2NzEM8i9rRSJumEQ+vTf2wST9lFvQen1ioHL+wUkgIaAnCh0/1qgrI?=
 =?iso-8859-1?Q?a4RRDrYHa6twPxCDURvoG5oiYX+7o/38JU+BAFhfzi6GafAsNC0mrKRR5w?=
 =?iso-8859-1?Q?IOFCW69CB209ktsgJpFrqa40jKx2GmKQJcv7FWajeOUnF4biWFQw5YV5jr?=
 =?iso-8859-1?Q?kRw0B7JRQAV23763YeLmnolyMmGc6Gi9LjaemWD12rGEsjIhpKG9cSMc9L?=
 =?iso-8859-1?Q?Fx9cgzFuO/lNOWcNMbiAF3DsSXrt8MXuToj1Pk8z4kGCwIEFT8dYS1YPyo?=
 =?iso-8859-1?Q?MJfhXguOmDZFIcGiDssEW+rXS4QifPV7NMBA9ODQI2qtnQZhu2zU/J2HYy?=
 =?iso-8859-1?Q?QBDlxWhP63wZFQnlYo2CJWVPgY7CLJksFM4aXTolv39LQxc4wwGz1fNDVW?=
 =?iso-8859-1?Q?Jo/QbU3l/cTVajkiP7YUXSDsqr4Om8cToiKtajCkEuZXdRfI/c3JDg31Es?=
 =?iso-8859-1?Q?ZTllnKvqiVEBniWSNYK6dYUZnNjKlx7vTMV6JRJmUor5v+k3CxfcAtM6IR?=
 =?iso-8859-1?Q?5Ev27wCVPuvgq4ZsptB0K/Sj0VkKnQli2PSRea8yUBcaRRfJfLnqJ7VYwf?=
 =?iso-8859-1?Q?Hs25zaPofHROaid3bVBED9nU5gCkf2g8AkcSMALsUcxY+icejciA7J8m4w?=
 =?iso-8859-1?Q?QBLq43mBdqoSoUBCFBqkV7VQB4sEDAeGWfv1kq8VSRs3sTvRJsCTynyWg7?=
 =?iso-8859-1?Q?fFCyfMdAhluELfTr4ivoCVA/PiowFTCSLZ+fldXvdHTtE3jhd+W2gRCIh4?=
 =?iso-8859-1?Q?OqFSfpIXjY0Pq7dcZkqhXdUWpoGE0gNArjGeoDB0d/hxiMV5PDuQ3CZaKF?=
 =?iso-8859-1?Q?2sUIWnq/MEVD1XLv47HQAjulGCiqs0VxSCDVe1eSPmm2FtyHWSiGCGtC8M?=
 =?iso-8859-1?Q?gbfQAP5bInJ5dZaLhwkUJRYTV1eZRW2n4yvcC0HcyMN+ybDDIeYITms9MP?=
 =?iso-8859-1?Q?8z1dbnwug+1i0M1XxtpBTvsnRvsoorTDd5ZPyo6QJ6WlEiy4sFPPfCCq8+?=
 =?iso-8859-1?Q?LI+J9SN+WRd7xzfAVkJ7qvyKpcMGUA2Z8huPw7JE6r/uXHlRQGqa5hCcXj?=
 =?iso-8859-1?Q?BTyodeYA0XbUdyvTbjVaT6ZIf2/Prjtd2AfS4GrDoHQ0j72WLGmKBdRx7E?=
 =?iso-8859-1?Q?epuP8rdnJ9cr76SGijoA3spqEL4F/gzrAtdas+fTdw1E/Ddb0yZVM1wV9N?=
 =?iso-8859-1?Q?+FM9oqhOFHnUkyDuYypUmdDSzzpgNqefFPU5fC++QRZ9sXWaDpblQR54v5?=
 =?iso-8859-1?Q?jGm23d0AKwOjRF6adKlwsGuVsbv9S4xrk7WBdjd7HlW6/0+vL/kU4leM4Y?=
 =?iso-8859-1?Q?VHOtmGTgINX9Cp9C6WmGCp5IymP3cr54p2Ch3feZ1Rdeg0YjkE2LZar8eg?=
 =?iso-8859-1?Q?5YXYjAEg1ra49c639QEEGlgCEPNj4KIQJ/jux/WS4OMJpyES40Zy+iawqc?=
 =?iso-8859-1?Q?Xz2LmhIQW0VrbV+T/iGv21TXxBX5ACKBxupvtH5ryqlToAoqHRT0H2Xjmz?=
 =?iso-8859-1?Q?vvl/WJUT4D5R2CYg4c2MvfiLko7mQjAHtU00fS+UH07QGogmq1VK+MUFVg?=
 =?iso-8859-1?Q?GeaVPj6qkf8vxe/yPrcgdUxJRv1UtwS6Ld2ZT88oQeN/UwdDSJfnwob3Qf?=
 =?iso-8859-1?Q?sc3hnAxSmCHD7A6n+lJZwTehP87f8lOWwBfu2+LC2NlDUMjGpfjodB7oGl?=
 =?iso-8859-1?Q?9XPYr2PraA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3374e4b5-5177-4001-2b93-08de68843899
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:21.1855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2uXSREXNjaIQkYOEth3uZnJhehoVjTYb2lJcGbPLHNVy8Q7OFY1eDHvQHE9bMvdaLYhsS5DnsYFaJ/TrC7zbYg52GxzMqfNL3nuy0jLVwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5264
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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
index 8c6c0a9a32..d20ec383df 100644=0A=
--- a/meson.build=0A=
+++ b/meson.build=0A=
@@ -3602,6 +3602,7 @@ if have_system=0A=
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
index 9e6c789ae7..c53f94d96a 100644=0A=
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
index 1022bdb806..e05dc4864c 100644=0A=
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

