Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F560A262E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=CbBBTJNt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXhL-0003aS-K7; Thu, 12 Nov 2026 11:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xRXhG-0003UT-Pu; Thu, 12 Nov 2026 11:30:48 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xRXhE-00053P-MV; Thu, 12 Nov 2026 11:30:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCDgOd2wBD8hApdbFCfa1wK80/8kjNeZ3dEDVLHEdUSBlnDhi90FISBENUixOjL6hEM2XSuGblLHcPnC881AeYHv9rpiV9tNm0MRs3iaGgl73C1ve/MmsW9JKgrLpAUJoO0Y2ZgdmQ1rX1dDN0TJV9RXfN0GT6fUakvcbqtDDWckQLiSc+KDPX9+O3SvfxcyPhotxPt7D5DH7WgmUvTBDC6ZWW0bIEKtmGHYwFQxbcGGARVFlkDBSoy3vwdT9+wOz25Yzj/h3cSwwbjlNtdBC9CXNJGWhvH5noA1GFq6wNHdYiOeW/TGBaB7k8QJaZ/Tjly+db++PmoR6gfE9K7pMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkHxSuJa8T4lyKtUYatyekTJ9qxxEjLGrKMjxn0XV34=;
 b=flDHL3WCJ+Y3v/6h8EOpZTv2R3UKRlLrTNO6kT9Il0WpNM8I89fGsZbzM5SnsIESOyvf09w4VxOTp80Z3F3aSr0G00PyNPwe1oyqiUxOIuu2TpZoh1faUwPkn+Y5X+7pSmpFvgmwE2qDwVSEpd+XeHujsjC/2ooe3EPp0bMs1w8lU7EQ+aEAV7qnBIaWigFa/XS1sod0RgOVhKE0Qne39sYmy7xYvOnVhcSaOhou1+dzHsJcRLeRQy73ut+VD8wCKz27BpCTohX4gsNQwSfU2mJiS9rsvE7Bvyp/MxODcOhd9W6TlefGcKUpRBzH6S65I+m+BT6hThVOg5ljdbNHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkHxSuJa8T4lyKtUYatyekTJ9qxxEjLGrKMjxn0XV34=;
 b=CbBBTJNtiOSO6siVKuHRJ0O69frNqS1WV48ESw6qr4QOAmM399yJlA/2ST5ZiMfTwPc/nWqEIcnEU5L9OkglAn00oIVYTtoCEd8EBTVwYtvGnBInvimJnyMntW0f0ZRiGUTeRFMLYkNWd4hmHrdTgFCELeb/18GxKk41MiBC5dYek6VCGIr606R6cX3CxN2tyrmkR6GjX69/r0WpYdDbFVyG9zfqyPbTsasKs0uvLf0DYJyObfI82vuLpyNFet5urIQswO+LY9iqwsv+KdGKNkT8RbPpJkR2jyX4Jv4HGo4KcOh4T1CyaNHbtkAOVYoT5rnqyBSDdPlKvyWavJIRWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6189.eurprd08.prod.outlook.com (2603:10a6:102:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 16:30:35 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:30:34 +0000
Message-ID: <6b7efb67-c3ee-45a8-8bdf-b9122e819c39@virtuozzo.com>
Date: Thu, 12 Nov 2026 17:30:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] scsi-disk: fix UNMAP and WRITE SAME racing with
 inactivation
To: Fiona Ebner <f.ebner@proxmox.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
References: <20261026174220.674460-1-den@openvz.org>
 <81fde20a-d822-493d-825b-a99cc970ab71@proxmox.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <81fde20a-d822-493d-825b-a99cc970ab71@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000015C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::87b) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a8d39d-84c1-4bea-22c0-08df40da46b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|18002099003|261009223027099003|22082099003|56012099006|260925021311599003|260925022911599003|260925021911599003|10067099003|4143699003|261022105027099003|261022115727099003|261102123227099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: YuLy1Fmztp96qkxLjLp0JMNVIH/61rOdpLrf68mFIx/yDoUt3jZsYbCX9CVpqoyNXF8w39S4rJKb6Sh2u6wFMBPtAQkSX6+GMswby/0vIbq9uHY3q1iiHxSZcfcR11yndwHpd3T8g7H2kkzK5dnDG75sQab6hfucwM2NfOUlVu0Kv8ix3ZQxV3OpQ8ViGD8ge3QKhizvFjEOB7H841389Ayw4b1wCk802AHmUOM8STh+Jq1ZDhkOwZ+qQHC1V4GbzVQQw4QZaaJi3XGmLyA+P5W31rDvDUGKw69rETPLbGIRxVQ9kZwgKC5fQngzW75z3Dz0dGTOxhU413/niGOEFUQ0uyUYsM3f/fMjG45N08WpaqnQ6/uwwpuDty7H64E7bs7koXiLcAR/nhTcn1qJrDvkiXEiIVKSsaEp74GH7WgOteNU5zwuUBnQZ8AxJ6jsFBXsmD9cThmzqmbMwGTwLBHU1YAOHUiF426NYBPHttUYIXEXCClSDCqQHBUpeIMVkQdYhexWJzOM4SNnGACnWorM1WLML95+6en5iPjVKmGFEL7p3/bcbNNm1sjVRn4Ta6AUeikhonc+s47/cX8lmHxwYtM8ky5CEkgl1i0W8B+XCsSsJ/bAcoYxFbghAKxI2232ABySoj5vVAw4e59VW1fqi7N4nAYlcBGXY/TGpJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(18002099003)(261009223027099003)(22082099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(4143699003)(261022105027099003)(261022115727099003)(261102123227099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjBzc0dlaDhCaisxODkyV2s3VS9qT3JUdjk0T3c5bnJKNUNBdWZjQ0lUQ0Fl?=
 =?utf-8?B?S0pidEExcHJKM0NXV2F1ZHJUeG1LRUs5TnJhSWQzb1BMRkx4U3ZqUmkyT3Nz?=
 =?utf-8?B?OFUyZFRlU2d0TWtiQzEwZDE2bUlHaTJBVDFyY0hJTVBhNzdkRmFDTmY5SVp5?=
 =?utf-8?B?bElRM0xOQlA0MlpGNDM4bE92TGJ2L3R3TjJ2QzI5M2o0NWhvbVFlZExVV1lQ?=
 =?utf-8?B?bzFWbnZ4ZldMSHZtVm1wcGM2cVBmL3J5Zjk2aDBhSmpXME94ekt2Qm94UVlz?=
 =?utf-8?B?SGFCWksrdUdxK0w3ZzhZQ1ZXUlFWRTJYK05scDVjY01XQVVMSjJNeUFXTVgv?=
 =?utf-8?B?UUNSZGJNNEdOVk9BZkR5UzNqTGZlejJlQ3pZb2J1YkV1dFpHbE8wQXJnVkFF?=
 =?utf-8?B?NkhoZ2piRXFmTHVBbC9HMC9MRjVaei80NDFHdGV4UnRvTEhhdTc3NFBFaVNS?=
 =?utf-8?B?RUF3cDErWG9jU3MwUTlXUk0rQnhxZ1BrNjEzTUNKOTcra09BOUJqY2c4VlBO?=
 =?utf-8?B?SVkyUnpWY3RHTG5NODU3b1VML2VjcDVOb05KeS9jY1RDUGJTMnVLcmhFWEhm?=
 =?utf-8?B?VmZiVEt1TXBDR1I0MVN4SGIzbmN4RGo2b0R5U3p0NjBVa2t3MUNnT2lBWDEx?=
 =?utf-8?B?RWRKdmluMFZ2UmpnS2FPN3dxMGpxSXJDdGY2eHgzSXhZSmVTYlQ3NUI3WDZn?=
 =?utf-8?B?Vk1xU0R6emRuZHFPVnlyc1N4Q3U0dzE3bjZTWDZSVmpqcUFWNll3cEZnUmp1?=
 =?utf-8?B?RmhpWWtwZDhmWWM2YXpLV1NabHJPTjdJWmhIdk95cWVYVVVUVjlJdFgyRUJz?=
 =?utf-8?B?aEIyZjgzY3BKZmw5T2RzWGZjdWttRjhtd2ZMeWdKNTNWcnZaN0Rpcm5vWm9I?=
 =?utf-8?B?MWJmOVFER21ITkI0UXIyWERrdGFSalhrL0VPaVJ2cXZodDR0Y0lGcHBoYkgw?=
 =?utf-8?B?M0M2NGpDemtNMmFkbE9tNUpEMVN0RWVCVWlJV3BvQ3ZrWC8rK3hqYjdtMEpZ?=
 =?utf-8?B?QldGU3Q1WnBTSENoRDIxMUlQWHZrN0FpTVB5NURTWkhFQk81SHQwWlNBQUNz?=
 =?utf-8?B?SVBnRHFVcU1RV1VnVzNOb1J1Q3RqNnROVWpUTUZWcWowaHFJV2VtZWNYNU1Z?=
 =?utf-8?B?akduT2JQb2haYXJNUkV1cGdHM1ptNjFyTHNDQTg0SU5DZXZSc0NLY29zU05Z?=
 =?utf-8?B?SUkwaktmeHRlSUlxTk9hM3lRQmpIQ29GblduQUNodkliTlBRZTZ0RFg4VmFu?=
 =?utf-8?B?ZTB0bmNhejE3NXdYOEUwalpuM0NYQTRIaHNVcGJZUk82OW9JSzh0c0VpdWN0?=
 =?utf-8?B?VCs5d0hjTFV1UXAzcWxJZHdJdSs5Y3lleU1WK0RLN1pFRHkweTdZVzdVaVpR?=
 =?utf-8?B?YXVRcFd1RjhrN1RNbCtSR1NDaTdMakQ4MnU3L2FpQ1NUbXFzNWhoZjNNaVlJ?=
 =?utf-8?B?dk5scWZ4emNWN2xkUFVkZzlKbDE3aHhpc2VDSW92VHZTZVBCY3FNemVZVm9B?=
 =?utf-8?B?RkxJaWVqWlZKblZnWEwxN3JZTnh4RERULzJXcGEyN3grL3pWRG1jUUJaSjM1?=
 =?utf-8?B?WHdOM0FWSEhMMFhDZllkM2pmT3JSU2R2RUovbU9sZldLREdZZnBRbThSeTB6?=
 =?utf-8?B?ak9IZStxQ2VHdE9HVkxPZ243c25lOUUxeTFsVXUzQTA2M1ltQ0g1bnk5eEVv?=
 =?utf-8?B?VHE4aUw4b2JMUkFVWjExL3JrbGN4NWEyOGJXbSs3NHFoNUJoZGlKZUZIZEZB?=
 =?utf-8?B?eUZaby9WTmR2eXRwMVhPcDRJVEdCQjEyTWdVVFpLenJkWG9XK2lIZE0wK3ls?=
 =?utf-8?B?aUM4OEpPMlpNTzVGWU5YWWI4cVBteUdLUElFU1ZPd3ovR2pHNC9JbDBueHhs?=
 =?utf-8?B?WE8wYnJOSmRVdWRpNzhZQW0vNGpMYmxnRTg5QUJOTTRUYVo4V21TRHpYR05v?=
 =?utf-8?B?VVFzUEpOdTl6b0xDMmZROE1tdGc5T1R1M1hIQjJsT2xhYkdJdVNzZUloWXFy?=
 =?utf-8?B?bnk0OGJPSXVubkVHQUFSZW1qZ1Bjay9TSDY1bytZVkNwOXhlL1l1M09WSG9O?=
 =?utf-8?B?aHRNUHZESDdIQzJ6WlB2dDNKT1N1NXM5eGlHOWhRbnFtTDIvVzY2R1pCaDlR?=
 =?utf-8?B?Ujd0dDdlL3dXZjBrS09aUDRhZkljRWF3NDg4ZENhS3VrNTVBSXRPOVJKbm9E?=
 =?utf-8?B?WUhvbXhkejFMQTQxbWhnZkhIM2lxM1F6N0czakl6SS8xWm9HR01hVHdZKzNt?=
 =?utf-8?B?a3duenR4TnVHZWtUQnFnNjVSQUFUM21ZQ3piTWlBeExOcElFVmduUm8rL1Ay?=
 =?utf-8?B?NDlsdTlBbHoxYU80bmg3Y0xTV0tVNFhwQUR3NGdaVkNCYU5Ld2NGZkx4WnVY?=
 =?utf-8?Q?QsRFo//5d+2QTM7eKU5kahfzxhxwpVKc+1mm6Ir/6qES6?=
X-MS-Exchange-AntiSpam-MessageData-1: Tpo/PAgz4jW3zw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a8d39d-84c1-4bea-22c0-08df40da46b7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:30:34.8600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3NqzZu+1noehqUw6HkViuVr1XEJNWGCQ8HUkZouLTvAC9s0ScFKnmbvO4VHvJDqQASokQOnsmxG4+0VI0RuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6189
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 17:02, Fiona Ebner wrote:
> Hi Denis,
>
> Am 26.10.26 um 7:09 PM schrieb Denis V. Lunev:
>> scsi-disk splits UNMAP into one discard per descriptor and a non-zero
>> WRITE SAME into 512 KiB writes, submitting each step from the
>> completion callback of the previous one. A drain in between only waits
>> for the step in flight; the next one is queued by
>> blk_wait_while_drained() and resumed by drain_end. When the drain is
>> the one in bdrv_inactivate_all() (end of live migration,
>> blockdev-set-active), the resumed request hits an inactive node:
>>
>>   bdrv_co_write_req_prepare: Assertion
>>   `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
>>
>> We hit this in production on a guest UNMAP with 38 descriptors.
> thank you for tackling the issue! Unfortunately, I was still able to run
> into a crash with your series applied on top of v11.2.0-rc0:
>
>> Thread 12 "qemu-system-x86" received signal SIGABRT, Aborted.
>> [Switching to Thread 0x7e5ff390f6c0 (LWP 382537)]
>> __GI_abort () at ./stdlib/abort.c:95
>> warning: 95	./stdlib/abort.c: No such file or directory
>> (gdb) bt
>> #0  __GI_abort () at ./stdlib/abort.c:95
>> #1  0x00007e5ff7ef7420 in __assert_fail_base (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=2000, 
>>     function=<optimized out>) at ./assert/assert.c:118
>> #2  0x000064d2985a7d47 in bdrv_co_write_req_prepare (child=0x64d2b3419550, offset=0, bytes=512, req=0x7e5e468ebdd8, flags=0)
>>     at ../block/io.c:2000
>> #3  0x000064d2985a786b in bdrv_co_pdiscard (child=0x64d2b3419550, offset=0, bytes=512) at ../block/io.c:3217
>> #4  0x000064d29858ee94 in blk_co_do_pdiscard (blk=0x64d2b3419050, offset=0, bytes=512, flags=BDRV_REQ_NO_QUEUE)
>>     at ../block/block-backend.c:1821
>> #5  0x000064d29858eded in blk_co_pdiscard (blk=0x64d2b3419050, offset=0, bytes=512, flags=BDRV_REQ_NO_QUEUE)
>>     at ../block/block-backend.c:1849
>> #6  0x000064d29817105b in scsi_unmap_co (iocb=0x7e5fe0001c90) at ../hw/scsi/scsi-disk.c:1873
>> #7  0x000064d2981712aa in scsi_disk_co_aio_entry (opaque=0x7e5fe0001c90) at ../hw/scsi/scsi-disk.c:1797
>> #8  0x000064d298785586 in coroutine_trampoline (i0=-1308221744, i1=25810) at ../util/coroutine-ucontext.c:175
>> #9  0x00007e5ff7f27810 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #10 0x00007ffd671cda00 in ?? ()
>> #11 0x0000000000000000 in ?? ()
> I issued an UNMAP with 4095 descriptors, all discarding the first
> sector, via sg_raw in the guest and then sent 'blockdev-set-active' to
> deactivate via QMP.
>
> The device is
>
>>   -device 'scsi-hd,bus=virtioscsi1.0,channel=0,scsi-id=0,lun=1,drive=drive-scsi1,id=scsi1,device_id=drive-scsi1,write-cache=on'
> and the blockdev
>
>> {
>>   "detect-zeroes": "unmap",
>>   "discard": "unmap",
>>   "driver": "throttle",
>>   "file": {
>>     "cache": {
>>       "direct": true,
>>       "no-flush": false
>>     },
>>     "detect-zeroes": "unmap",
>>     "discard": "unmap",
>>     "driver": "qcow2",
>>     "file": {
>>       "aio": "io_uring",
>>       "cache": {
>>         "direct": true,
>>         "no-flush": false
>>       },
>>       "detect-zeroes": "unmap",
>>       "discard": "unmap",
>>       "driver": "file",
>>       "filename": "/mnt/pve/nfs/images/100/vm-100-disk-1.qcow2",
>>       "node-name": "ef0f65238260b2e5517e288d10debc8",
>>       "read-only": false
>>     },
>>     "node-name": "ff0f65238260b2e5517e288d10debc8",
>>     "read-only": false
>>   },
>>   "node-name": "drive-scsi1",
>>   "read-only": false,
>>   "throttle-group": "throttle-drive-scsi1"
>> }
> Best Regards,
> Fiona
Great thing. Thanks a look for spending time for that.

I'll dig further!

Den

