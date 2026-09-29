Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C74CCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbKa-0004Hy-Vs; Tue, 29 Sep 2026 13:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbKX-0004HB-Qf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:09:25 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbKV-0001VI-V6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R54Zzv8Mc/Dl1qUVbkXnHzaAGnkcl05ExpOwrVIMdlYzT7D0LsTNuuGeLr3gkduq3J07DPPxBjI3SeqJ+dNm5PCpiM/bMM/nqhqDpzyaBL4XEf/ih17vjfKjDMXzoz1ZPSdOx3iNGK3S3YzrRWC968jcnR8hdShaGYbWvrrcYMkH7Q8p6mJjiVtSD1dXL2k2dtyDwyiiW7EagyTpJno/JhzjZlsn805cajF1dOusVWwO/zzVpog1dgLQZkmLubUbtkFSqvJZ6X9UA052SH+60rRailwnOHOZod4VnEqSjrQ74JUYtt8Ei25HCrO0XhmrSHvgvsVaD4WbneFIEuVUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTHY4bJbnq92BDzs407uv+lwj9WH/1ac4B/r/EbzDMs=;
 b=QILqv6fSYta4BxkuqKPuhYn+vwNIU81XjTA742HjHS9/3a1nhHUwOifgVLdSE19bR5x/cfHHVG+wCSaHa/4urD4jl+lx5G99dD52v4WK7slBmnd0Zr0piXGhhtNYRdlI5wgkhMaFm4eZhhwc+Y3sx5vX0qJHAGkFriouXLQ3eSJlG8koOIRLoAwPS+lns7x9FL46QbnC0C0gjCmEhEqkRvUnxXSM241HLooZmC1Wy0RVQgpHNRVEPMWIGUc1+l852/sdiqNcM5AXEZDZtIsDmrZYAyECyd+NMAed1Iwe7yyGCdxkmZp6AJA2/5QYEcykBL+M7M9zrIG3dslL0MhRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTHY4bJbnq92BDzs407uv+lwj9WH/1ac4B/r/EbzDMs=;
 b=e+NMdJtHn4wiTak5O10CBPnbeImp44Ghy3GS/3Q8g5g1L0rjIxUtST8aDrkbQGqAd6OmlLurXhKW4K6A7pLmN1i41zpi6YNo4zmQduHWVcngpY5YH+tZ3uO9hQKLVMs1FK4eZwXXXmMMUwniHjRIEH7apijx//r7r03mQbUZD7+08NynwQ0jIT9FqhtNXZU0OluHhciTJlxW/klZjJECQtU234eYP+HYizX4G3XGyR+ajVoZttB8+700wvIT7L1PfQSUibSPfc28EU0tGWqswle6AWGnV8mqhX/Q6cpa1LZrwYCxsi9vDvgLXiArr/5YiuGXvihTcOXiZzap+f0ojA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9336.eurprd08.prod.outlook.com
 (2603:10a6:10:3f3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:09:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:09:18 +0000
Message-ID: <ba3453b5-7f69-45cf-8b85-78777c5c03b8@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:09:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/16] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, den@openvz.org, sgarzare@redhat.com
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-1-6ef9ef033c35@virtuozzo.com>
 <arp4-P14_JP_-ABU@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <b4b8545c-18f4-47bf-9182-a326f8a9136e@virtuozzo.com>
 <arvbRylSxww1824g@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arvbRylSxww1824g@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: e1063932-87c1-40a5-307d-08df1e4c65d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|376014|10067099003|6133799003|56012099006|22082099003|18002099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: DyfWsNlWLa1oub/1pvsYRdm/KDdky7e3LB3SKjMG5kBob5zqzP0JGc/xffj+Ld64nMm9VOyFj15abyUl6Uj64z5cIDp1HlAJlYUSu9nhEpgy89B8VpucmTxpR0GDML8dWjnWFzDs6hfOtv3+XtVeEt9u/choHqpTSU9Qd9ulbH8bes0qSNV84O7hcyE7dPm6oSrzEjezlbI7Td2mdHcgQgoqgXBxACX2M2D5ErItGf1NFEqzovny4AXes+Eq+dxLfRpnBCj3DMJAesNDsEwNrJbEtJ1MWyB9ZL7XE4vqwrH1itBjipGIqvaq5GvKAHGY6JnfR2XrN4hFssfZPdNn07wr1inLPrcimxj7dV9oujaZ67+3U9gD2jxfx/r3oiPKOBpAEySjxPsg+0bzqxxxNauI0o2Mtwhq5w9qD9yYA6wUwbObBCjKM1CXw+GddY6/ltv8rvCaTJ+3LpLTf1rda75Ynp4Cqxn7NiAwnVOdocgBqnJwsQQ/ZmLRTDUByyqaqIbYlgtsd2Gcz5SFFxm/BM92eLwHQzwOYLf7tXBxCMGb6J9lbqsOZG/YGMc3RQcLPipT0oZzycALqm+aWwk+U+eKctBnxNexzomZttYuvFh2EfoNryJS40NKrmqwSC6YFx4WdfANILSVzf5FZ/i5QAdbHxf8GSlxBhS/JQKDI6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkIrcnE3UDlEVGpaZzFiWmFTQU9vaUdacVYwdFh0ZHV0aS9SWGJxZkdoMld4?=
 =?utf-8?B?ZmRSb2MxSnd3dWx5V0kzeE5IOHgzOFBFdHc1dzk4ekhyTEpGM1dXWkFBKzhj?=
 =?utf-8?B?Mk1KbWN1M3hEMWNJY1VaYkFQQS9SOVE4ekdUMEZWZkNFRHJXZjBlRmZ2UjYy?=
 =?utf-8?B?RTIxakpoQW15cjhBL2huS0tOUzEzZHlwNy9Qeno4NWVmbUJBRjh0b1NuZ0Y0?=
 =?utf-8?B?MWVDK1c4QlBIZ0ZSMFVVMkxBR2JhRk5hL2Y1MExuVm5sRHhsbWJWc0R3TmdP?=
 =?utf-8?B?QnpSam1UdWlpalZuWVR1Tm41ak9xL2xKYW85UndzYTJDVXlUSjFHQU9iUWFi?=
 =?utf-8?B?eFY0Q0k5cGNtT2N6MnhVRVRHR2Fwc0kraHk4QWtQQmlXeUswRlVQTUc4cFlm?=
 =?utf-8?B?WENKdFo0Z29oRVBDNlNob0lCQWVSZ3N6ckpmRWZVUnVpaXkxODQ0dUo4TVJv?=
 =?utf-8?B?d21wQm9MZnpIM3FDMWNtV0Q1UlJOdmQyTTAySEVoYytMK1pZMEJjRDU0azd4?=
 =?utf-8?B?OTl5T1pQcTZ4Sm9CY3IwZHVad2F1ZGtUOXY3a0p4MmJ5b3JCTmdMR2lzcU1S?=
 =?utf-8?B?dzN5VlFaU1NFd01TanRiV09xb3ZLVCtHZElGMVpKdklabkF2SnU5YkhyemRo?=
 =?utf-8?B?VlI4UmZNbmM3VXlaZGtzYllFanZRYldRVm1adHB4TDEzU0ZEbkxxTk9xdmRY?=
 =?utf-8?B?alpkY2pzVkVzeEx2d09CZkxVZ0w0TEl0aWNxSThxcmFvc042b2xXRzUxbVgr?=
 =?utf-8?B?OWZLMVRUbkw5V1JGdlNqUjNVZmdOZ0ZiOHZFbkovVEZlZ21YZ0ZUYVBBckZk?=
 =?utf-8?B?V05EOEFsVWtDVGVvQ1Y3eHplWGMxTFF3N1hHZUdCeEFmc3dCS2tySHlaWmlZ?=
 =?utf-8?B?R3RMM1JYWDJLK1lDRXdvOCsyckM1ckQwVURITzY0SUFMK1BoZzRrcXk4Q2dN?=
 =?utf-8?B?MFdlUVhSNGVFcjlueUI3RzhEWWZMdDl2THpkdDRUdHFnSXBaaUlFK3p0bzNr?=
 =?utf-8?B?S0VMK3N3dDYzdlJ2Z3kvQlBJYW1nUEZjQzhveTFzbDR2Y3Budm8vVkhOVjZM?=
 =?utf-8?B?d0pFMWg1WFdlSEVPK05WNjNMOUxUWm1nQ0IzVEVsTm81UGYzOURPT0tUdGVE?=
 =?utf-8?B?bFRuNXBoQ2FHWFo3Q3JWamgrOGxMSXlHNzRVVi9kNHhQMyttcklPTXpHRzNk?=
 =?utf-8?B?cFp5VjlHQW9sK1pSejhPNk9CZHJ2MFhKdWdmRnVHZ2hFYktiU2wySE5hK1JP?=
 =?utf-8?B?Uit3ekhIS21Sc2E5ejA2U1hpcFIvN0oyUmdJSHVVUDhuZ2IyMDNFL0hDNytE?=
 =?utf-8?B?Q1cveW4yV1NSNW1Odm9uQzRxNjR5V2x5N28wOXJhU0pML3BiekI1SWVDNFAy?=
 =?utf-8?B?aWpjR3FDQkNRMkVweXMrTWZGci8zcEIweVd4V0ZZT0N4Wm1DdVczOUYzUi9p?=
 =?utf-8?B?TmVUVUtMSTd3SFZra09kU1VCNnI0NVhGYmFmT3FOVEM0VU05enY3MG5WWmZs?=
 =?utf-8?B?Nlh2aUNRWm12aW9QU2kwM0RTQjJyKzRMSGNlVEJtbmlwUHBFcDBCV0JkN25o?=
 =?utf-8?B?ZVIwYktWQ0tsQmN6ZVZpN3dMM3ZkcHVoSGZLck81KzN2ekJScUFRMGQrUDRR?=
 =?utf-8?B?MXVtV2FSRkw2TVE1N3hzZTBHTmtrNnFpRElSZ1RFc0FpclpGazAvRXpwQzdp?=
 =?utf-8?B?MTFGMVJXaHRiWVI4TFFYN011ZFlsUy9NWEd5b00wb3QzSlU1UkNEUWgzVzI2?=
 =?utf-8?B?VjFHNFRQaUJibGRjUkRVUU9ZWmo3N2hsL08xVDF5cHN3NDJvbytLeWlkOWFP?=
 =?utf-8?B?TDdJR0tnNXd3QmcwUHQvY2Y1emVBUlB5ODhxUzNudnJna0xpd0g3LzM0SC85?=
 =?utf-8?B?OUhTek9kbktzMlVCWjNzMWliR3pIdUxrQlJ4WXdpdGtzT0IxQlFwaWJUd3FQ?=
 =?utf-8?B?THRRNkl3VjlhYnFLUVI4ODBPMWdxbzF3TnNzL1lsQ09qUFF6MTNyV2MxOWZF?=
 =?utf-8?B?ZzdkWlYvQk9aMzJaU2tOVkhhcXBGRXora2laZXJlc0dvaVcxbXVuL1luOURQ?=
 =?utf-8?B?SGVhaTNwam1RVmM1QzhNQkRpVVhSV3loNFhidHZXWE5xTGxRRTkxNFFDVjhR?=
 =?utf-8?B?YmtJU1YzbVU2M0RhZnUvOVBnYlBHOWg0a2dkK2MyVGRKc2FFK3FCRkhlK2tn?=
 =?utf-8?B?VFB0Nis5ODlMQ2RjWGJoNHN4U0lzKzNoTG1pRUN4QnlOeTFUaUhEa3N3d1ha?=
 =?utf-8?B?OUxxWEFxL3JQU1o5TjRYWmIzdE94L1llMGh5UXBTaFZpV25ReWZNWTRsM2kx?=
 =?utf-8?B?UnVNd296NE0xWUlMOEgralg0Z3dtcHIxYUhOUWsxMnh1RExzZWFYeEdOOVJm?=
 =?utf-8?Q?CzgjfTnjzOZVOQ1M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1063932-87c1-40a5-307d-08df1e4c65d5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:09:18.6072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6bHlI0r1FbVExyRya9NgfB9MPocKk3MVLyUPxsZCQXbhtKJxhb4hvtVDkyMQ3LSmr5069Oby/i+0K80lGB9wH9pXLKm4wWvtzQC01kdDrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9336
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/29/26 6:37 PM, Peter Xu wrote:
> On Tue, Sep 29, 2026 at 04:28:19PM +0300, Andrey Drobyshev wrote:
>>> But I do see the existance of cpr_resave_fd().  I confess I don't know why
>>> it existed and didn't check.  That looks exactly like sometimes we can save
>>> the same fd twice, if the 1st one is fd=-1.  Any quick answer?
>>
>> AFAICT the sole purpose of cpr_resave_fd() is to be called from
>> different sites with the same (name, id, fd), to make sure the key is
>> registered in the table.  What it does:
>>
>>   - no entry - save it into hash table;
>>   - same FD already there - do nothing, table isn't updated;
>>   - different FD present - abort as an internal error.
>>
>> That means there's no case of injecting the same (name, id) twice into
>> the hash table.  That is actually consistent with our patch here.
>>
>> I'd leave the code as-is and only reword the comment, if that's fine
>> with you.
> 
> The whole cpr_resave_fd() API is confusing, I still don't understand why we
> need it: we should make sure the fd is always properly inserted, and only
> once somehow.. but I agree it's not an issue for the current patch.
> 
> Said that, for this patch, IIUC we still should need something like this:
> 
> diff --git a/migration/cpr.c b/migration/cpr.c
> index bca43e9bf3..d26656c5c1 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -173,14 +173,13 @@ int cpr_find_fd(const char *name, int id)
>  void cpr_resave_fd(const char *name, int id, int fd)
>  {
>      CprFd *elem = find_fd(name, id);
> -    int old_fd = elem ? elem->fd : -1;
> 
> -    if (old_fd < 0) {
> +    if (!elem) {
>          cpr_save_fd(name, id, fd);
> -    } else if (old_fd != fd) {
> +    } else if (elem->fd != fd) {
>          error_report("internal error: cpr fd '%s' id %d value %d "
>                       "already saved with a different value %d",
> -                     name, id, fd, old_fd);
> +                     name, id, fd, elem->fd);
>          g_assert_not_reached();
>      }
>  }
> 
> Otherwise at least from API level some user can inject one fd=-1 entry,
> then resave fd with something else causing cpr_save_fd() done twice on the
> same (name, id) index, triggering the new assert.
> 
> Thanks,

AFAIU this bug (injecting fd=-1) is non-existing at the moment, but
surely adding some API hardening won't hurt.  I'll include your hunk in
the patch, thanks.

Andrey

