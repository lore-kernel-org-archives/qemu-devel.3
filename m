Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38226606A33D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=M0flpPgm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPGJ-0002x3-6d; Tue, 17 Nov 2026 14:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xTPG8-0002vl-Bs
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:54:28 -0500
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xTPG5-0003y5-Ra
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:54:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M19TNnIFI6zRhw1M3DoubTR0rpekbqrUdwZyKkZ6pU+v6PTR1QYMd97SC191jIHnwROzjjZwYphIcg5HlW+mcXKhxllEbEBU4dw3STF4xejE1KE5bewjM4GSQrJv8mFeeStDwLkVHC4TKcNdMoI9UUlk0iAmZ3FgaXA5+VHy2cN/LApKm3lvNDDi6gblx9Cr5wdi2jUpCnNxblkgxBai869iXZ0JTmOG+C1477mxQUTfzOoVJZIhctwkcKEGaVc3OJSAevsNgsp6uG95vEX0MduU1I21Jm+m4TT3yMkpxOyYZDTmRnAsHbE5ZSLDajSjpsX98a9yW3qgjnoZLPjCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1TkE6s6MPwpzOzgTg3Tfc2xKWK8MLF5uOJTz5iNgqk=;
 b=tsh9jCLm7DiCrqzxhtC+V/6zuoh0XNBch9paP5Q7LIA8gwA2B+YfNP18S21ul3dYbjSeOKh0y+RRswmVveF9/f3Q+vitcqdcIV5eZabUUjj0VaY9gFWxJeiuiNH9eAA28rQttb3mfiA15a29Yr3Vj8F/xkFZzbb+m8Aocynk3ABz7W61fK1iN8ifh7vElD3P53s4Nyp2bEh5rsjOtCgS2CN9k8Uat1ytMoq1qbWrGhQkT3yvaejjvfJkS8Vj0FkgHH3oLGNiIim+CllmZaTAmDy3CnSwRb+SGj6OaK23hnhZ+UjrNNLjCxjIx+wJg2RHeClsXHxSFPhy3WW1HGLRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1TkE6s6MPwpzOzgTg3Tfc2xKWK8MLF5uOJTz5iNgqk=;
 b=M0flpPgmqFoud556h8/uQ2zGjNGGPoJhNUQUnZDJcEGrn6t9lHgIaWsdEkSukRgRUDxV8zWj9ZKwmO/7qkrDfvn5i6406IQxL5mVO/u+py2DkLBhRBSLNv1pyTec6Jw9bxd2H+vU0Pwtkeqjn794F4wYRgPCrLJK6op8LQckEjHnbFw9CgrbE4nLCnB4hmrtCo1a4aW0luosF1X4r4by8KA8RTMkolKXdeWMaeUV/iotaOpoX0FbUOurmfl7vyXNsIZPqiL/qOj2C2INJRVXTewcsvBHS3u9QHnmR5pfqBMH85NDsM40dAvxTwqP4mJfZCSGu0lKYbuKO79opsd+GA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by ZR6PR08MB497186.eurprd08.prod.outlook.com (2603:10a6:910:dd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:53:45 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:53:45 +0000
Message-ID: <805b4bb7-eb0e-477b-8ba6-9ba9f89e1f03@virtuozzo.com>
Date: Tue, 17 Nov 2026 20:53:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] virtio-scsi: fix hot-plug event racing device realize
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20261023162000.2796947-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261023162000.2796947-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI5PEPF00000920.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::93a) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|ZR6PR08MB497186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4facfcf8-d75e-440a-db17-08df44e47d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|3023799007|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: UwZA+9kCkQ+xjchFDk+tpQDhiUBUo5hM2NBvGD9CTC29IpuhbhmMux+6E5kjAPU3PU+Ozgzs5vQbEuzpF/wVBb3C/1QIiw4XmbE4/f5T79OjSy13ZEYISoacOPR2tnPeWEtsLUWA4/ofBlA1RmdW3h8qCPEdsW9LIeJl3hr4PVvRIbOdHzk3YjPEVIGuILPasjEtlE9EL0sNuavF7fs+sNskzHhu7LCPpZwlvUXh3h7XPG3osIHkVLsWv9MhkPT0gceMErOcDIH/FTrQHM+U4npA9J66OEDlMA3PcIo7CLaBOB6x7CXIA1EKa13fvS9PA52/YuWNGOMcvlQX+7unTdUI1cjTN7MFiZQH8+lB2Dx7iLJi3jcaHleElGABNU640j2Gp2CiWPir11ZYeJNePfWbvUZAGVcX21URBOTL3Qzr6+UGxdVkZNVC/CB3L+d+1abJjp8g0e1Y8YbILQqEdac8QAHSGX993HYEqT9mahowxo5q1U3FOfd32qH0aBs1+yWoWtcjsWTK+j6U1lX7GDI9pE1Y6RS8zQ8MLOuqAwBpKW6YT30xqCujaYUDm1JysNgF3ol5fUU1SjGnwQXLj4W81/xFiVT4QAjpnSEMwVmnDKZwP0cwP9sXYpdrIkQsXiNlWYX5EmoGz3Wdh/5mq/iYb7cJNVhX6o7QDXbiXpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(3023799007)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFM0WjFpTktTU0gzMzQ0OUNBbFR0bG93dVJDTXNGQmViWUNDT2FmN0doK2Nu?=
 =?utf-8?B?Q2VaVlFla3VPaGxHYmZtSXptUitsa3hqQ1RJcFNzUExyOG5IcWU2aW9iSHlj?=
 =?utf-8?B?a2NndzRGcVo1ak9oWi9hN0lCWkdUcEVyK3VmTDg5eVZvUWhkS0hucjI4VTkz?=
 =?utf-8?B?dEViTDB3SWt1ZTN1aW5hS0ZpNzQ0WS9tbHdrTFB5WUswSHpPSGhucTkxUDRS?=
 =?utf-8?B?UDVsR2I4TjFHRm5raVBXQktHVXhLUERxT0NBRlZ0VjArU0RwR0VmYmJzU1Zi?=
 =?utf-8?B?UkFqM3NwOVVRKy82SThNSElNdTdVdnVqZGM3blhVeUp4ZFlKR00vUmQydzRF?=
 =?utf-8?B?MFNpSXcvQ3lVSUVUekpjRXlmdG1NUVNldDJaaDIrZFZQMXVCcEZMcjFKRmxP?=
 =?utf-8?B?SmYrRzJCNlgvQUVRVFdEbU1lV29HZ1ZYc1ovVFpQeHRyUDljUzhEd3hCWUFm?=
 =?utf-8?B?OUk3YkE0dGIzdndMS2hVSVRGTENOUk0wdWNWNitCODExUi82aWdjSEx3WmJl?=
 =?utf-8?B?dzBhYTU1ZzZucGs5dTdxTFRtM3k3ZTUwVUo1Wmx1ZHdwMk9uSmhKSUIxSEpP?=
 =?utf-8?B?SE44elNZcnlwK0pVejFxclhNZ2w2SGtPWWxNbFpjOTBndlIzbFE1a2ZPQ1ZB?=
 =?utf-8?B?YUcrUFZTQWFFblVnUUp4NEpVWDZNcHlQNzdvY2tZQit6WDZBTmUreFh2T3pP?=
 =?utf-8?B?NmVBSlpMamVNSVVhWFNyaEpPYUdWNDJpbU9kSDlFWkkydHQyOGdwNHhnQlVU?=
 =?utf-8?B?TmF3dFozbFBNVnl3SUoxL05FWkhyTEFuY1Nnc3R2R2ptZ1NrTnYwKzIyZmhs?=
 =?utf-8?B?RHQwNDVmKzFOSHRFbHhsSHg0ZVh4Ykp0SVNPTzRScEFibWk5MDc0TGxRWEFE?=
 =?utf-8?B?R2ViOUpIRjJ2dld0ZWhPQWt6ZEtRV3I4QmNSNzgrMFl3WVNXRktzRWNueHJ6?=
 =?utf-8?B?Zzk3RWZHTmJIYXB5eXc2b3FGRjI5NEdCNnpUbEFKV01OdUlGUjJsR0hpaTRa?=
 =?utf-8?B?M1VhQW41ZlJhbG1IWCtqRHlyNHppVGdCMnpBMFhZdHFOeTM3QUp3M0NydlIv?=
 =?utf-8?B?Mk5Ka0hTS2RVMzdxK081WXZMRHk2VVF0Z1BDZVNqY2NQdGV0VG5tN3M0U1N1?=
 =?utf-8?B?WGFYMitSZlZGYmdOZVUwWDFCVmN6Mk0zckFRVG1DVU1CY2MwWW9LWmRHUjhZ?=
 =?utf-8?B?SGNaUDl2SytEeXpaYnFwUC84elFiNDhVM2kzdDE1dWRQM25TcWJ4ME1ncWlz?=
 =?utf-8?B?S21tNkIyV1NTemZzTWxVeTlGdjYyd1dSL1lwY2doaFBFZWVOK2tYQk5FTGlG?=
 =?utf-8?B?Z3ZFM041V20ySTREVG94TTZheXFSdmY2cTNJaHJ0cXp2bTIyZzhJRnEvY3lT?=
 =?utf-8?B?THB5VXlWU1NLRXkwUFI4T2F4TkUzamxmTWR2WFkwdCtUNW1HWTFtUWY0UXV6?=
 =?utf-8?B?MVk4UzRNSDFPcUcxVmFHbFhHaE1objEwcHNPSFVLNUtDQ1Y1VmtueXFJbDdm?=
 =?utf-8?B?MVI0K1NKOC8wNTcyVWtCUi9QZUNKRVN1eW4wTlMrbTFiM09oTm1YMnJjWXY1?=
 =?utf-8?B?YW9WL3hOU2x1T05BNklILy9iMWpibk1ISjBONTlGQWhmK2JYb2t0RGRSays0?=
 =?utf-8?B?aEpNODZnangvWFNibUNjQU5VZkdVN1pxd3Z3WXpNZGdpTEhEUDB4SmFLUzJ0?=
 =?utf-8?B?MHFkK3Vtd1hBYXdPSHd3cGRGeU05N0cxbWk4UDFrS2QrMHEzUFhDQXkvaGtL?=
 =?utf-8?B?bVErcENwV05iV3ZKamxZNUhYcWw0MkFaTVNKTUhNZE5WNyt5WlY4ck9xb2hY?=
 =?utf-8?B?YnUxZTlNbDFUaGRZYWltOVppWjhFWFQ0YmhuR2Y1SFJYOGU1UkUrcXNKKzUx?=
 =?utf-8?B?b3Y3TEFyNDhSZUJpOG1HWmNEckZlKzFKTnI3UkRDYXkvWEhkWU4rU3k4TWRB?=
 =?utf-8?B?OG5MTTRwc2ZwK0psUlFOdDdOSlRraEs2cTBFYWIyeUNnSDNsVzlzSEppcFpM?=
 =?utf-8?B?bVRGOFZKTm5Ya3JPSU9PeVV1Vi9kWXhwMmJCQzNFNHYreUhTbjdTZ1RxSnRn?=
 =?utf-8?B?Tkt1d0Z5RE9FU01vQlVRbDR3NVJIUGZKaWJyL2lYWVhRZ1ozTk1aWGlyYXZu?=
 =?utf-8?B?K1hacWMrNGZSSnhUNHZhcnJKdHdoRTZCQ2pkSTNueW5XN2Nnb2NQMkI3UzBD?=
 =?utf-8?B?MFA5cVFTNVBpaVFtQTRXaVJkS0dHalF4Mmtkd3FKaW5wdlBvNW1nLy8wM2JE?=
 =?utf-8?B?QjY4VmxvMXBWd2ZjS2FxTGFyUXBxVTQva2pHcWw2c3RrajM0S3g1RWhzMXpm?=
 =?utf-8?B?a2s4Wjh5d2NHUHNWNnJxcjRxNERQYmc0WjJRTndwcHFMTE12OWJIdUZ6ZUo5?=
 =?utf-8?Q?f2EnmkdfbgqQzGSu9lXF5U9xLEIHXU6Pt/tQu?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4facfcf8-d75e-440a-db17-08df44e47d33
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:53:45.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm/gB0g1lIjoQ30b8wBljXCh9p3FsyujSUgflbffQl9yi2kYRHqaDQ1SjPblg5Isfz+Gn5zkBawRrmM45nPwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB497186
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 18:19, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> A disk or CD-ROM hot-plugged into virtio-scsi sometimes never shows up
> in the guest. QEMU has the device, the guest has consumed the RESCAN
> event, and a manual bus rescan finds the LUN at once. We see this in CI
> with Windows Server guests (vioscsi) and with Linux guests, always with
> the controller on an iothread.
>
> The event is pushed from the plug() callback, before the device is
> realized, and the iothread request path does not see unrealized devices
> since 8ddf958e8d62. A guest that scans right away gets BAD_TARGET and
> does not retry. The patch moves the event to a main-loop bottom half.
> The alternative, letting the request path see a plugged but unrealized
> device, would undo what 8ddf958e8d62 protects against.
>
> There is no test in the patch. The window lies inside a single
> device_add under the BQL, and a qtest or iotests client is served by the
> same main loop, so it cannot send a request in between. To reproduce, I
> booted a Linux guest with virtio-scsi on an iothread, ran QEMU under gdb
> in non-stop mode and stalled the main thread for 3 s in
> scsi_bus_set_ua(), right after the event is pushed, then hot-plugged a
> scsi-cd:
>
>   break scsi_bus_set_ua
>   commands
>     call (int)usleep(3000000)
>     continue
>   end
>
> Without the patch the guest never enumerated the LUN (3 of 3 runs).
> With the patch the same stall falls after realize and the LUN appeared
> every time (3 of 3). Without the stall both builds pass, which is why
> this only shows up on loaded hosts. tests/qtest virtio-scsi passes.
>
> Every release since 5.2 has the bug, hence qemu-stable.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>
> Denis V. Lunev (1):
>   virtio-scsi: fix hot-plug event racing device realize
>
>  hw/scsi/virtio-scsi.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
>
> base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
ping 

