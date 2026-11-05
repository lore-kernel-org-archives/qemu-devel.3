Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94341606D819
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=J6FntUEs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvyO-00059N-J2; Thu, 05 Nov 2026 06:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xOvyM-00058s-NA
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:49:38 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xOvyK-0006CN-Vp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNbOjZxti3YTWSDVI90ylBJytvfnjqOsc/7bG2kunjT9wIIeL9fZhduZm5+lqosmObYoRAQ13yL7yGV800H+68GWTqMUmVuYjGybIV8cTEcCRFbHH8DZvnNQrJANZwsj97v2RRduPHKRqwW7A7cDbbkU8NKfy6PjtHEJhITbddBOfTGVhRY974JJb4oITzyNYhHqTN9FaoWkhnsOislKUArNifd++JkaWVFkEHcYDCYQBr46vO09baBtVYcFRvTGkTppnoz+WWTSnUGW7ioXwKGoge4TPUTj0fUcrtA0vpDmhMnw+j/c5e//J/7kXid+UccVpTZySF777/63jBLXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B932+amFP+j2cruiT+QHzQ0dC9MKgOR4gO/Qld9YAQ=;
 b=Q8Tp+0y/ENsxjRu0Rq/K2yQkRST1TVgYFpq/4X/PClLwxrw3iZRVISNI6PVAYJ1dj2mAcrLKhUjOGdRt8gATqkGKDGV8MrlmK517CbTCtqLaL58uKw9CmbSEIFobjBxp9NubvE0ZumjHNyefnzuA7sSEsboN85n0VILexXR6bSjAwvaox7tlTE5idEBb4kasvybNrHpuIl7gHdvKvMMo0IZRYztO60gyuwSKSKDH2NtDrhnIjv5mOcgkGpZfNVbS+FSE5ITRtpsgzJYl00VzppaCeO3d2EcObNd4YC5XSqw0o5HUV1ggxTy3FT3gQ8Q08cQKdmhpGow+1JektxGzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B932+amFP+j2cruiT+QHzQ0dC9MKgOR4gO/Qld9YAQ=;
 b=J6FntUEsHJr9Cv3nAH29Dn9p21yA4+or9Hx/LVRZbxNTBDAk6KE11ABvju9K7kh/HzVd1Qa1XqMZSBsiF5tN2BvDZUnWXude5nZCPQwPpet8oKbDDekgqMLqrGe6qzPq3jsMl1d4ph0t4qqnjuxFi9ciTuWzJAZhFLLBrKWBGUdA3FXAmAVlsqZDrlDpJyWlORfgMsIoBwAsQ8KMUaZQMKDRnuG+uc536FWJ3DsXBcm4iyEnlom+heJ52DSDKgNjspBvaeCuAy002MaUg24gXDOmaZYgFphwYQbjlIMHPGNajB1EmfNRLCdAueLVSEf6cC3ujMSOn2+UyRRIzC5uaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAVPR08MB9859.eurprd08.prod.outlook.com (2603:10a6:102:30f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Thu, 5 Nov
 2026 11:48:47 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 11:48:47 +0000
Message-ID: <ccb97ede-e91a-4990-821f-a3127d1fd4e4@virtuozzo.com>
Date: Thu, 5 Nov 2026 12:48:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/qdev-properties-system.c: Don't leak str in
 set_drive_helper()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261105114635.3286252-1-peter.maydell@linaro.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261105114635.3286252-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::19) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAVPR08MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa91c82-f36c-4423-7246-08df3b32c039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|376014|1800799024|261028144727099003|18002099003|261021121427099003|261026140227099003|10067099003|22082099003|261009223027099003|261102123227099003|261021123027099003|261022105027099003|56012099006|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: ofUahgO1sU61iU/+t2/Xqlyr1ytvqk6KaWQcdZex6sjqwyBERmCB2U7mjX5rWARedj2WfhUisrxAchtw7z1qNYEa10LYeVQPkAbLzOl9/4jUw+TCpZN9d32fzxcCt8Ug1lhXIeCGFfXEw6w6S7SXh1yNacytut/2jkeAriw1+95vs/u3N/L1ph/WpJGJTNRPx9dygmda+mhNzwgzngn05CSh2Vzz0ixNmV9zaXecYv/Blygo29HEx+8yFC4CDhPLkvnYIpzUuQ0E/wrDbKXBmEpHVvetWUehS6QjIxcf71WUk3spfU9jCNvqWrzBcfXvSu3ZJJXUglyz9dAmMNXk/Cscq8/fmje2fMbG1gQmxiWqESeeA98p0zhxHGr6V0qZNN+vtH89OD7Yp/fMbypOfS4QEx4Go+ofFR7n4wRTlv7XQLRNCW4ag28vqVy+DrhyWlWljJPeQIltqk/iE70ed0bi5gVCHV7kNTMy3OKuYaD/NnQFR9Rdb7WxorzEbipTAH95Q2o6quN/6ZtkPKy4ygYNfg0/rW/dGs8a11ekLyAD51Z1SIJBJZ6Z4vW0erVOxzBUyvnebIuO7/wZHv5OuNKvGkupCimOZoLSUg+Sm2ArpmfBcBYNwaI0ryHNQcisI6Sn4jaDmvtdFl91hGgDtmoHRN299Si+bfun0nBi2jg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(261028144727099003)(18002099003)(261021121427099003)(261026140227099003)(10067099003)(22082099003)(261009223027099003)(261102123227099003)(261021123027099003)(261022105027099003)(56012099006)(261026121527099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UExYdHdJWG1pODRSUW9QNU5qcEs5N1RueVhMK0ZoWnYzWlhMVmZIOUFvbi9t?=
 =?utf-8?B?MEFadWtESzJ0bksxZ0NDUEVxcVpoZTlkNEhLcjQ4OWFwSEhhRVBCT0RRZ3hp?=
 =?utf-8?B?WlpZOFRwOXE0cXZtcVBBWGdPekZ5K2wyVE82ZXl5VHFVTC9VdjVUNWJhT0Jk?=
 =?utf-8?B?NzNOZGp1MytDd3ZYSUhiR0dNU0hzUHAzRTFHMTViT2t2VTRQcFYxZlh3OFZw?=
 =?utf-8?B?ZUJSMDVxWjJpQ0x1NURkUjNXaGg2cURnMFF0K0RwZ2NyUFhkT0g3bWVEcnND?=
 =?utf-8?B?Zm8rNUhiTlBaSFZ2N2JYU1RDZkZEYXhVelltcDhxenkzMFk2WHI5YnJQd1p3?=
 =?utf-8?B?KzJJMXhOS0F1cVJ1VkxLQ21qczBlTHRabGRuclJNS3RXVUN6amlUcmNMbU9N?=
 =?utf-8?B?dGxiSUlrYnZCbEliRUVoSWh2YXFHRnRkN01QMW1hV0NjanBycE9PYUpaN25M?=
 =?utf-8?B?WmljbE5ITU9RNzZiT21TOVRVMzRQMlZ5RytZVzhYZHZQNGdZM2FaQnpRdStS?=
 =?utf-8?B?N2txUkVtUnZIZDJYbUFBRzRpWVNkS0JmalRwV3l2bHk5VXBlUjJZSHlOcUdU?=
 =?utf-8?B?a2ZUWjBUSStjQlJQTytXdzlFWU5IM1liMHI5ZUtsTHJLUll0T2RzaVVvWUQy?=
 =?utf-8?B?NnMxUVBSQnBtZUJkRnE5R2VpVWxIeE9mQ1YvdE9WaW4rWllYQlU3K2pHQnFO?=
 =?utf-8?B?enFqNGc2eHQrUXNKYkg5VGdFWmR3Y05WSmVXUjNnZ1VKZFdRSTdlZXRUNm84?=
 =?utf-8?B?aWVOeit5RXZKdzZNRk9hRjVSaDBsampIaGxRNFB0NGJlYjhkWGF4NmFCaUVE?=
 =?utf-8?B?NFl5elE5WjNuR280UVFNRjBNQ2VUK0lHZnhoVnlzOWRpYytpaHlvSXFIcExB?=
 =?utf-8?B?SmJadHhiMVpIQ3orSS9TYVRRblY4WVZvWnpoRDUxKzBMcDNpWm5zbHNOdFR5?=
 =?utf-8?B?b2htYVZCOEhRQUpoNUVxcVA3T08vRHpwZzNGS1pLMWJhTzZSZ05nZXUrc1NQ?=
 =?utf-8?B?b1Y0NWo0YjVaYjBtMUZUUXUrZlIzSE5KTTVPYlpTQjAxbWNIYnhmL0xIdjA3?=
 =?utf-8?B?WjFvTFlaOUcxaFJrSkRNR01OOEtYQ0tpem43MGRETzlUemNCNElEMDYvZGVI?=
 =?utf-8?B?V29zVENldENyRzBrMVRoRlErUXhjUHg5elJ4Q1I2QkkxYVROc01rUHBoeTVK?=
 =?utf-8?B?ZVZkMms2di9TS1JSeEdPeVBNVVJuSEYwVXFHU1o5N1ZwcFB3L3hoeUVhc1h6?=
 =?utf-8?B?bHpBWnFDVEZtVElhdlZQOXlKcEg1cjVhR0RIUmRoa29UYWxaL2VObXNMa2VO?=
 =?utf-8?B?N3BvbDZKY3dMazVWQlF3Qmk2ZURINDNVdXVla091U0pqQVpKaWZ2cWQ3U3RS?=
 =?utf-8?B?V3BCM0NTV0lYMmFVYWlzalVTVHlnNjZ2QStPb3ArUkQyLzNSMjBaQjE1Yk1M?=
 =?utf-8?B?aGRhalA3VWFreGgybkFBV2JZUnlBTGhyQUI4QVAwREJvZUc2ZFBpYkltaVEw?=
 =?utf-8?B?MXhDemFUakROK0prTjJVZkFuSStxR1FGZDltbXNKdTVBYjB4RkZaRU1jcWxr?=
 =?utf-8?B?UHRiRDNRZkxER1c4eHNRaVhWU3Ixb1BXb211S3NVQWlkeTdiM2hsK0RIRFJt?=
 =?utf-8?B?RlcyR2JyREZnKzg4Q0p6Nzl0UXl4U0p3WXpKdlBmaXA4cHdwMEZQaHZBZGlr?=
 =?utf-8?B?Z2ZGS0dQRWI5eXhxYkxnSTVDMEkwWEN2VXdtOCtFbWRXcEl4MHVPOG9CSUdm?=
 =?utf-8?B?OXEwaFozdllGb1hSZnMvQVd2R2RGdWl4UmtHWi9nWG81NDFhd2ZiT0ZZVlFD?=
 =?utf-8?B?eGpSNTFDZlVGVlEzRGc4VmJTS1NIYThZZlpXR3VIZnBCQlYvUHgwc0YxYllE?=
 =?utf-8?B?UCtRMlAydlpMMHB4YWFqUnJiSCt2ZlEyRGhNNy9HaU4vaXdFQUZrTllMc2ky?=
 =?utf-8?B?T0dOZERqUjdxWkdEbzNpdFQxVnZvQ3FNSU9uM05ZUDNsWTBmVFZoSlAvaGEw?=
 =?utf-8?B?Y1NxWEI3dU5zWlpMNVFZRFQzMjhEdEUvU0s0M3lHSkl5WmJNczhJbFBHODBJ?=
 =?utf-8?B?VVUvWCtYZmtRNjFyTk9sNWg4cElHVlVIY0xMT1dibW4vaE5FZHNBZ1Q3VEVC?=
 =?utf-8?B?a00rMkhzbU0xOEQxQmxya0N0aHB5ZlRrWnpHbjd5V2h1a2FHMWhud3Z5T01z?=
 =?utf-8?B?NkJCMWhENVJ5S3lmWXZ6UHdsMXd0eURmMkQyaDR2d2o0c3cxZzhXcnE0TzZj?=
 =?utf-8?B?N3dKYVNTcDdudDVUdGZjOUdsYUk1TXY4YUxiMUdFUmdhL3dCN3FJcnpaTm5i?=
 =?utf-8?B?WmMvVkVRMHpjOGtRNU00RGNvVkwvQnNRUkFhYVNYdlZUa25KU2RqSGRKY25h?=
 =?utf-8?Q?PgqLPe7pUAT8t9op8i32dXu/WgXB6sjaGfFrkmOIyftzi?=
X-MS-Exchange-AntiSpam-MessageData-1: NpUM5emdMjB91w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa91c82-f36c-4423-7246-08df3b32c039
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:48:47.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA28Jaym45L1wvKLm/pdILfp9e/CQUrQQ+Kqfnua/bUcr2Ql5U8t+4oXiPl2rbOSrT3QsBPUlsQdqS6rwm1ewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9859
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=den@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

On 11/5/26 12:46, Peter Maydell wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> In set_drive_helper(), we call visit_type_str() to get the value
> being set as a string.  This is an allocated string, and we're
> supposed to free it, but not all paths out of this function do so.
> In particular, the "block backend already exists, change the attached
> node" code path does not free the string. This shows up as a memory
> leak under the newly added virtio-scsi-tests/replaced-node-size
> qtest:
>
> $ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
>   QTEST_QEMU_BINARY=./qemu-system-i386 \
>   ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 \
>   ./tests/qtest/qos-test --tap -k \
>   -p /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-scsi-pci/virtio-scsi/virtio-scsi-tests/replaced-node-size
> [...]
> Direct leak of 4 byte(s) in 1 object(s) allocated from:
>     #0 0x55f7744155e3 in malloc (/home/pm215/qemu/build/x86-tgt-san-dbg/qemu-system-i386+0x20115e3) (BuildId: 271ffb42d2e322de7813813d8c6cc85351e48a4f)
>     #1 0x713dbd345b79 in g_malloc /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gmem.c:100:13
>     #2 0x713dbd35b988 in g_strdup /usr/src/glib2.0-2.80.0-6ubuntu3.10/debian/build/deb/../../../glib/gstrfuncs.c:323:17
>     #3 0x55f777208021 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>     #4 0x55f777208021 in qobject_input_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qobject-input-visitor.c:542:12
>     #5 0x55f777204d1c in visit_type_str /home/pm215/qemu/build/x86-tgt-san-dbg/../../qapi/qapi-visit-core.c:349:10
>     #6 0x55f774df80d1 in set_drive_helper /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:129:10
>     #7 0x55f774dee9fa in set_drive_iothread /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties-system.c:224:5
>     #8 0x55f7767cc5c8 in field_prop_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../hw/core/qdev-properties.c:89:12
>     #9 0x55f7767ec12b in object_property_set /home/pm215/qemu/build/x86-tgt-san-dbg/../../qom/object.c:1562:5
>
> Switch to using g_autofree so that the string is properly freed
> all all exit paths.
>
> Cc: qemu-stable@nongnu.org
> Fixes: d1a58c176a11b ("qdev: allow setting drive property for realized device")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Sorry for forgetting qemu-devel on first send...
>
>  hw/core/qdev-properties-system.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 4d605c20561..d5b227dbecb 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -120,7 +120,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
>      DeviceState *dev = DEVICE(obj);
>      const Property *prop = opaque;
>      void **ptr = object_field_prop_ptr(obj, prop);
> -    char *str;
> +    g_autofree char *str = NULL;
>      BlockBackend *blk;
>      bool blk_created = false;
>      int ret;
> @@ -155,7 +155,6 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
>      }
>  
>      if (!*str) {
> -        g_free(str);
>          *ptr = NULL;
>          return;
>      }
> @@ -209,8 +208,6 @@ fail:
>          /* If we need to keep a reference, blk_attach_dev() took it */
>          blk_unref(blk);
>      }
> -
> -    g_free(str);
>  }
>  
>  static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
Reviewed-by: Denis V. Lunev <den@openvz.org>

