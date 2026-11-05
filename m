Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E075606B445
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=z/ddyQjX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOztH-0003K7-3c; Thu, 05 Nov 2026 11:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xOzsm-0003B0-3a; Thu, 05 Nov 2026 11:00:12 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xOzsi-0004AN-HJ; Thu, 05 Nov 2026 11:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=magEB1kIKDdjY7omSrKASSkdICdGfE9sveHVYAOHmHqsRfF6kzO5EgILxWEMkEfJGvrw0dXjxrY5a96E0Z0jZd8r4FXQnkPAKkGX/QQQiK5IAgbeHVFOrRM45gc5ZcXn0v8twIvYCZajlXn6Vn4PIg6u2PmwE8xUzpY3SiNGTl3cfa6aLOUpesZ3jE2PFTeQEjgrClGlxxB9g1+AfGdZg1CQmnvq3Y3AUv8rVtoyOvxyG/a8aFbUH2WwPsgEVfrnhdS1b3VDDrETGv2a2lhkO04EW5guuiV4X2PWUj+Um55niFCMpttunn65SlJq+W0e6r+KqHT3o/hmJtpL+JPi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kc0mntGKqAjPWHXg/1TGTRmqOO006lxJ5ae4fRNkXQ=;
 b=B/3hxNHT5XNwAZjyfmT35bVBhCkkHWIeEvcHRaPUSOCvXcaV0bBWqykS3xcf8o8JHcUc5ZzUkO4mb9NGiL8JzoRYE9ztj7X+M90UA+jyQlmogCHmpP9i1ZnXUoCNcHpzp9VqnRFBFWX3mcBuZEiNQyl0WC0VoW/bQf+7kuBAW4ti/CaCGX3O0MBmCBGvc+KxRJptjARep1O6QePIKQrKMkX/CmRKrSzfx90HPsHQzrSVOayM7Thxmhxh5PDKsKx065yu8/6w4g2bkspW2JSW0B2p/2BbLBTibgRQ3NCK+viTNb2HP/3hP+VJqWbAdQ+RRg7bwSyxChbRd3nk3XBa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kc0mntGKqAjPWHXg/1TGTRmqOO006lxJ5ae4fRNkXQ=;
 b=z/ddyQjXKtxDBZxPd/pcoSQx+RGg8vr7l3RlYKv4fuao3f0RmS1lGWC4+bdBhpwd1ZvumtcTFf8qdWU7WjaX8lmA5PudeNeEgLIbKUwg0Ykm1Tfl6NQshjS8xra6Ku17gIJs3KiDrtqo11FyY6qwNLT9u7AWMxU5ixLJI2fb53xOSEfYcoJKHV7iSCghnWPDIOAVo85jjX9xCLP89VldA3sJj5Z979OKvBp876ZhPdIwwugNzvRLWHPSRhdYXtGm+wa++hyb5xk6LpqY0tj3Q924dzuchj7ntHuES4Vo7Av2LVuJzz9tIcboNp5rxTKQRPoUb02SGWcdqY/7sYsvCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9443.eurprd08.prod.outlook.com
 (2603:10a6:10:45b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:59:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:59:55 +0000
Message-ID: <47aee2da-8436-4911-9f5f-4d200e6f1a4c@virtuozzo.com>
Date: Thu, 5 Nov 2026 17:59:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iotests/290: add test case to check
 'discard-no-unref' option behavior
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, den@openvz.org
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
 <d7b02a58-5fe7-4f60-80cd-bb9739c24d67@dupond.be>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <d7b02a58-5fe7-4f60-80cd-bb9739c24d67@dupond.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 48608981-73fd-4459-2674-08df3b55d57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006|261026121527099003|261028144727099003|261022105027099003|261022115727099003|261009223027099003|261022075727099003|261102123227099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: X+6H94+cSa2dz/6zj+fbGpMIXR171ZoWyLlM5KpFmxvu03ZeAAVEpanztBHAV3jz5TN+OHcYkBRoasyNuJzMmUX5nTYPBbVUWxBTBC7siUCWKdALeSJ1CmTkxwu5A09xd152OMkMf44i9VusfgghTtfv11Wks+yeM+Jo6eBoGA7WVfogvw/84wQeA4hdAmSZY8Nqi8sKJXXns9xcxhnbMVrAh/XqONnFRIGFpvGCf/VTcA5virSiqK+QB5Y02H+udIuN7ykR4NI37WIW6vuyUrat+1rwiXUP9B3TGs/Nc/ugIzRZt0V6utHNB3dh9qbVK3vHuCkfkNox01Ln9TgBtkZDzxnVkX5qm9k1XnDqqyAABwtAIafW4GKUdW5z/XJCqs16LhfcoCfTuETqtAzN61G+jwEBRjY+HkwuhfVGQvT/CZPc3QXnK7yZwjLXGjGS1S+WgC/ulvnec+uY/Vrt8rBwfFkeOetKRLSRTlkmYre+wRGzCXAdJFeH2z226DjXiVAvGY/hZZ7tQ7jgW+84ZapkMDZoDX8PzwqRKTXpJTZdQU7TsfsMTDcFHJp00PVRoGXKrPl3InrG8oAuQi7dfkbW23XTeG4x+ri3pDRQmE3TO7Gi8GsQgfjiUPbwbsY5PbcV/Qe7Dhg8GKmD9iFw/8MPj2jnX5rN99pA786rH2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006)(261026121527099003)(261028144727099003)(261022105027099003)(261022115727099003)(261009223027099003)(261022075727099003)(261102123227099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytqUGZVeHJkanh1TjVXaVVIbnlUZkN2aVVwNXY5MGFhSDNJcDZqV0lkWE90?=
 =?utf-8?B?R0dYd29vTXp0RExONFAralZ2by9ocVNGS29vN0tid1lMVU54Ymp3SnRjYWJG?=
 =?utf-8?B?cCs1RWpEWjNXZnJiQXcyOGlieVMxcnFXTkZ1MzZjZ2J3MmdsdDl2REs0RlpC?=
 =?utf-8?B?UEs3enpNZWwrakRqdFVkS2I1d1ZBR2pOTTlmWFM3emY2a1JCeU9qTUVnZElz?=
 =?utf-8?B?L0NNU0Ixa1FWRGU4ZWVZbGVmSENyMzRmbUNaM1BaQlRZb0FQNXY2S3E2OFFM?=
 =?utf-8?B?c3IyWmpWdWsvS1VFUFh5NWhKSDYrNk1PNXl4SWhEU2t3aDhnWGZldERIcFVN?=
 =?utf-8?B?ZEdacTFoTTY5bjFCc2w4S2hvNERLeTR4cU93akNLdUNMZ0NicGYwbEEzWFNr?=
 =?utf-8?B?OHRwTHdUNXVkK3VHcURCTlU4MW9YVGtFVzNPNVYwY0grVjcwbTFHa2RhSHVz?=
 =?utf-8?B?RDc1cTdYVHhFeDV1WGl0bUp5c1o1ckVHN2Jla2t5R3U2YTRkaDJ2OHNwOEs4?=
 =?utf-8?B?TmtISHZ0UGQyeHFZZFFJd1QwOERCcWlrY1h5cStWNEFTc1g2dU5lbUoxOGY4?=
 =?utf-8?B?cm1rKzVsdzMveVAxMlF4VHpUQVB1eDVYekkyVGZKcENiOTd4M2hPOEI4WG9o?=
 =?utf-8?B?RWpRTVVuaW9JaVdIVGQvWGlpcEc0VXBDOFRyWEpxSmd5K3puZWY1a0lpNkFB?=
 =?utf-8?B?UWNuYllKUlRTeVgwRnJUUTNXaCtla2huUnA3RHVsMXA4aHZxcTFmdDFsbTkr?=
 =?utf-8?B?VGRYcTBOb3JwaEZ0T0tieFZjd0N1ZGtwSXAvT0IwMUZDOU0xcTVHb1dOQUky?=
 =?utf-8?B?TUgyVC9jVEIyM0NWVitDVnRkS1lmNHhiTS9Kb0ZzTFAzZ3VSczNsRGVBUENF?=
 =?utf-8?B?S0VNQWEvOEwwYnA2cy8zbE9KMjJDMUhWeDJKQUs4Qy9hbVR0UCtRRVMwamJC?=
 =?utf-8?B?SzBjdjRvQi90ajlRZUt6VWMrQ0RTemRvdi9FRUo5Yk1pUlY4YUlUTldaeldx?=
 =?utf-8?B?a1V2cHN1MGpxN0M5Tm45ZmlGYllqalNUNVNKUVVjbEovNTRtSnFaL2pMZm5O?=
 =?utf-8?B?KzBnM1VhUytScjRxYmw1anRVVmY4cDVCSnlmWEdCSW45MC9FRzBJK2RrN0dW?=
 =?utf-8?B?dnFGMk8yeC9nYlBXYjBGZkxIVmRidzA4RnJzQXVhTFMxYk5TNzZtRW1sTCtJ?=
 =?utf-8?B?YlJnanExNXB0WkV0ck1nV1g5TklOTUo0NlBJQ2pMWmVFb3FyODBYNm51aEpo?=
 =?utf-8?B?YUJIWm1lQ1ZCTmt6bENsRTNrREtOck8zOThkbm94NGFSYTk2Q2IydzZ4bU03?=
 =?utf-8?B?Zk9RWS9iN3ZnMngxTW84R0FkU3hUMWphWFJjaGpDa0xacGozb04rUlZiaGNE?=
 =?utf-8?B?MlZGZ2dZZ1N6V3F5UDBkTVRsbDFRVUFzQUtYbGt6SUNwK1hmQ0s2YyszNVZ3?=
 =?utf-8?B?WFZJcG4vTDl2OXRNZmFBd1hRWHRnSFk5R3BXUXdlU0JtL1JvQWU4WUhlOUZ4?=
 =?utf-8?B?WHVLNm9ibmxzNnJEb2dzTm5TeUVtcGpxMzZzMTZNaWpnNVdGeFQ0U1JXRDla?=
 =?utf-8?B?WDFoVkE1dGk1bmxVek5PYVdvTHpWWis1REowWVpCYWxWYU9uSnNZSGcxTWNI?=
 =?utf-8?B?VzhJZXdIb0pzb3dOMW1SVEs0Z21zcmpMMnFWZ1k4V3ZGaUhBNkpjeWs2Y0dH?=
 =?utf-8?B?NmxKQm4xM3V4dWlMeWl1TGJZMkhwNEIyUHJoeDFZUXpzQWM1MTZrOHF4Tk9F?=
 =?utf-8?B?SEVjUjN2ak1sRWNROUZ5QmZhamd4TUQ1YWxHdW1uNDZFb2VKaStFOS9LMGpj?=
 =?utf-8?B?VnErVG5TL0hkUEQwRVNGUVJEUkhDRmNVbnJHRWw5SnR6eHByZmhHTURMcVIz?=
 =?utf-8?B?ZEZYdlAwRzd0Zm0xUnNWcFIvbnk5amcrOW41bWhRcU55ZU85WFVydVZwMXJn?=
 =?utf-8?B?OVVsUWZUQ2xXZE1QZTV5RjQ2WmNXTVpDakN0VEJwZGZ3bGt6NC9oZzNOZmZi?=
 =?utf-8?B?SmJoaStNMlZLZ2Y5K1VVaDM3NHZwWTUwdng0eXQzK2pRYkM5b01NUEZMSTJV?=
 =?utf-8?B?dWszbjFOUEw4OGx4UzVlU0xvYWRqUmJ3VkVSYzJ3OU5pb0NBQjFBNGZlYlRv?=
 =?utf-8?B?bkZGSWV6L3d0ZXlXMnd1SFA2dFNHWUJHeGRZNzhQOU9oeDV0RzArOEdaWmFz?=
 =?utf-8?B?Uzh5YzZndThtTUt3VklxWWY4dHZtRGVKdFI3YmdydHppUjJMZmU4VEJ4VFYx?=
 =?utf-8?B?ejgyTEVtNndLbXZoc0Q1THRRdmZyNkJrNi9qMVpBKzNKTzFrMnl5anJnOUhl?=
 =?utf-8?B?Y2lRU1d4ZG9XYXZScVM4cmNpVzV2WVhuUGpzdFhIOHBLZEtwRnY2bjh4SXVG?=
 =?utf-8?Q?Bp+sTyU/42WrqTfU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48608981-73fd-4459-2674-08df3b55d57a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:59:55.0764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwTJRCvrCZFjhipdfARbmqDdnal9geWxcLajUtyHPds8IEM3LXgZTrA+dVSAzP19t5Hn3YBNDPPY1X5olnQDbnl/MUD3O8glcDsXoDkR96g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9443
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

Hello Jean-Louis,

On 10/29/26 4:58 PM, Jean-Louis Dupond wrote:
> 
> On 27/10/2026 11:44, Andrey Drobyshev wrote:
>> We basically fill 2 images with identical data and perform discard
>> operations with and without 'discard-no-unref' enabled.  Then we check
>> that images still read identically, that their disk usage is the same
>> (i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
>> both) and that with the option enabled cluster is still marked as
>> allocated in "qemu-img map" output.  We also check that the option
>> doesn't work with qcow2 v2 images.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   tests/qemu-iotests/290     | 34 ++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
>> index 341a25f96b5..152fd7c5d1f 100755
>> --- a/tests/qemu-iotests/290
>> +++ b/tests/qemu-iotests/290
>> @@ -90,6 +90,40 @@ for qcow2_compat in 0.10 1.1; do
>>       $QEMU_IMG map "$TEST_IMG" | _filter_testdir
>>   done
>>   
>> +echo
>> +echo "### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled"
>> +echo
>> +
>> +echo "# Check that qcow2 v2 images don't support 'discard-no-unref' option"
>> +NOUNREF_IMG="$TEST_IMG.nounref"
> 
> This file should be cleaned in '_cleanup()'.
> Happens in test 289 for example.

Agreed.
>> +TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=0.10" 128k
>> +# This should immediately fail with an error
>> +$QEMU_IO -c 'reopen -o discard-no-unref=on' "$NOUNREF_IMG" | _filter_qemu_io
>> +
>> +echo "# Create two compat=1.1 images and fill them with identical data"
>> +_make_test_img -o "compat=1.1" 128k
>> +TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=1.1" 128k
>> +$QEMU_IO -c 'write -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c 'write -P 0xaa 0 128k' "$NOUNREF_IMG" | _filter_qemu_io
>> +
>> +echo "# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both"
>> +$QEMU_IO -c 'discard 64k 64k' "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c 'reopen -o discard-no-unref=on' \
>> +         -c 'discard 64k 64k' "$NOUNREF_IMG" | _filter_qemu_io
>> +
>> +echo "# Compare disk usage of the 2 images"
>> +# Don't check the exact disk usage values but rather that they're equal
>> +echo "disk_usage(`basename $TEST_IMG`) - disk_usage(`basename $NOUNREF_IMG`)" \
>> +     "= $(( `disk_usage $TEST_IMG` - `disk_usage $NOUNREF_IMG`))"
> Shouldn't we call _require_disk_usage in the test? Otherwise the test 
> might be invalid.
> Also something like the following would be cleaner:
> img1=$(basename "$TEST_IMG")
> img2=$(basename "$NOUNREF_IMG")
> usage1=$(disk_usage "$TEST_IMG")
> usage2=$(disk_usage "$NOUNREF_IMG")
> echo "disk_usage($img1) - disk_usage($img2) = $((usage1 - usage2))"

You're right, we should add the check.

Thanks,
Andrey


