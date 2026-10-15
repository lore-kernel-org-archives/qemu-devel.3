Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B890CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHI2j-0007nH-Ie; Thu, 15 Oct 2026 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xHI2d-0007mu-0G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:46:27 -0400
Received: from mail-norwayeastazon11023114.outbound.protection.outlook.com
 ([40.107.159.114] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xHI2b-0007VO-9Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:46:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKbcGzFjrtTvahTCPAzEA8zMk46oT6JfpSlZs7MHhNAseJFV61JNAxxaZH+nPkqv4HB+ZJFnioytP24ZDHD+VevCstOdQ3/1AR/LU2w36n8pVq4j0tqBjP6y4JvBL7axDYwSk8TwPiHQJcHC7vF99MugdFxQOO21+QbFxNGdkCUmjsrGV0jUhcqKbYl7lOPwgtfwt03BCttyAHewYpx3xq/F/qj0uBLOC3BO9gy3jQCTe5jOk0dXFxBMcwlBS+PULZoYVcJQghSWS5A3Um5X4nDNbU+bHDXPAuqsYTLtTQmR4Dj63l518/kV/amK+wu8sVAyON3pytVeuwFEIbfZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbNFbXyAboipYmWgokL6UVhWTccBaRif2IirIVjzI/A=;
 b=AR8fUpfktWavr9HAdCbAwmb/KC/H+NtBVhO4kiMSaFYnlsMdOIyD4eFPp0p30hMU0X/gY7hL+tG09wjbX/KxMKyjh1RE3Eh/Xvcuf/RkDBhFPsZDI9tSTNYFHlyfte2nqcDxakfJ0EnpFJHTgblAWdvk42yGxvNV0No03B9Qk6R8sm+9fcFTjhfZ2KiTbeIwZuHXIvsnaCFg60OK4uYXgkyaqjpao6Rs/gCETFQ+qK/EkmrgFQxnEbCtscCoa7C/JzZX+WgHR7BNc6LW1khPfjVlF7o2YyT1O8RYsQ0YCrMWotndz/fSXyO9JcTTSALqMzWUiSXTmX3u3nLq1n5lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbNFbXyAboipYmWgokL6UVhWTccBaRif2IirIVjzI/A=;
 b=wj4nikUoko1HQTIXShhrWpV1DDneJlp7DJR2J1SK/6t6TzsJWiEvSiuozocq71Y2USdyJrZjbNxayPsuPofvDU49SUxuTg5NmtedN6Ao8Gj+JjwnVq/CwdzajX4sqGNF2sX6gXdSZakJpm7EFTceFL3jgy0G580sfyYE65htBJ8jCub8WdJCYfIcHuaHOcrk0EiinmZkhfel0ZvuiwSg5siJtCVFvQGirilyRwsm3cQY8o2VxWMWCCLqKvmNPx0257zOZAWj4G9wuBEE74ComqxLotlfFse1snFz4SCOno9d8RUZ+cV+A20cEoF74g00AKIgu+hVlV6gv/R47dwNpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9824.eurprd08.prod.outlook.com
 (2603:10a6:10:443::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Thu, 15 Oct
 2026 09:41:13 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.006; Thu, 15 Oct 2026
 09:41:13 +0000
Message-ID: <45f8a86b-a19f-48ec-ae3d-78179c4e74c5@virtuozzo.com>
Date: Thu, 15 Oct 2026 12:41:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mst@redhat.com, maciej.szmigiero@oracle.com,
 sgarzare@redhat.com, mark.kanda@oracle.com, vsementsov@yandex-team.ru,
 clg@redhat.com, den@openvz.org, dongli.zhang@oracle.com, farosas@suse.de,
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <969c6698-d23b-481c-a941-dc1a5a9b2d50@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <969c6698-d23b-481c-a941-dc1a5a9b2d50@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: a716cdc4-201d-4d70-0b2a-08df2aa0730d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: /j/73g+Bow6o2ZmdN2a0ack0gEh1zaJVbE+Ep5YguNaMnUrsGZMscMRkMJqKnVLvi3r9VyEBQxro2yu5nbwapuqNDTkgau7FRrTwBcuBbioObBW9TWpOUQcnks+z3iW2pgpamgnUSliNS1yWZ3wL1/o0uMspmelTq/2S0wHFbY/Qw6JmpRw5Goab76+qxHUzt7UFznIWjrF9/ncclXkFPfObkEdie7NWsMEw+0NlfWvmA+LQL+GEAOrFKolkNWIwHxU+VOYEpHzuiQFyGcRGqRQpOEewRJ9GOpzS/wslYflGpzlEFRJf8NXC82387JilBzlRd0cs6wUeozk6nleC8Ea+pUml7JNGDmGgVzAXjQhggFUaGWkRPsHX2QyZeLrQV3i4NcSEAISb1rGqJtUI461crdoQZW5U7ps1JFtvgnBOdfYru0pb+78IvZcg2ZUb9VCxTKyYeeKKhTNERU4FprjKV4+FJSuLFYHabAxrXy1Uu34V2egcbPVYY4mBS8dY9dRiOo5FzmeFaQVHNm5MhaUoRKJpu1I9vyiesN+qfUtqzGFRj3752doP1l4AeckV7Ktf+y5AT4GS9np/m9t8MG6FoB3RsTnuLuNpcMPM2YapmXGgEkghUA4X7kpY/GsR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZYTDFQSStzck1DMXQ4SE01RjI0aHlrMWdmWmV0MUxKZWRHSlh5ZXVGdmNS?=
 =?utf-8?B?bTRDbnI0Lzh1QldrYXNibkYxS0V6OEI5MW1UbG1naG04MWdYOXB2aHBkTWZl?=
 =?utf-8?B?UmZLV2hYV3VzWklPQTlhRmtLMmROM0g1cVNTVkVkRnoxOU9xbW9DZndmbWZ6?=
 =?utf-8?B?RFp2SWE5TjlYaDdQdFV0Y2VIY2Q3cW9IbHZ1blJ4aFhDZzlZN2xhNkovTXpl?=
 =?utf-8?B?RlBhUUU3N2VQekh3NWU5YlM3WWlic1pOTHhybU5ZYjR5R0IvN1l5QlA1NFhs?=
 =?utf-8?B?TjE1Vld5elFvbVlCTXdHZ2t1b2dqaHdISG1HVnVSTFUzVFNQYmNYTFZoc3M2?=
 =?utf-8?B?Sll3eWdIandncGxncE1MZ3BRek1hNlNCaUkwSHV3aktCVmNESVlQaVp6T29G?=
 =?utf-8?B?VVFkc3NRczg4M1hxNm1tTmN6czdJbWp3T1JpK1pZZGN5bnNnbjd4bk9pUGJV?=
 =?utf-8?B?U3JMbUZ5SnFOYUN4aHNJMjNhc28zcGNTQTlUNmFtYTU4U01FUEc3THR4TlBJ?=
 =?utf-8?B?ZkFpcWRkQzNRcEV4TXJXdkZGU1JnZU1yQkJoQmdCZjhJZytVTjRSZjUxRWRw?=
 =?utf-8?B?VUZEMk5RTWFlNGozUnROSmNkdFZyNGhOaXhtaUNzUnlib0pEaFJZNDQ4RWox?=
 =?utf-8?B?ZFF4dFhET0pKTnE0M3paalF4YVJ2NE82ZDhONlY2ZmNpaUJ1QWlwMFIyRzBO?=
 =?utf-8?B?T0JKcWIrcWpqd0cybWs0OTZ1QlJzOC9UWUVWbktickZDdDhXUHUxYVVuemd4?=
 =?utf-8?B?TitLNEMxWFl6and0STBUamE5YUFkV0lGNGpCNU9YS2ZnQUdmcEdPVHAyMDhk?=
 =?utf-8?B?cXVYRVJrYVhyanN4WFd4TXFJSXpGRk9uS1F2aWs0WkQwdXpTVGhyRmRWTUVR?=
 =?utf-8?B?M056WGFsS3BlckROcDZIRlMwazdMblQyV0o2UUNvNlhFODRrQ1ZYVWtnbDdM?=
 =?utf-8?B?d3ZiZjFBVmdoQlJIQWlROFA5RytRbklycS8xZFp3VWFZazhZMlMxZm95UW11?=
 =?utf-8?B?MW83ODlMZE9kWE1SSXlBS1VYSWRkSXVRUUFhWHlGQThhdk1KZ3NiRERPQWgx?=
 =?utf-8?B?andvRmd5MTZWT2dnSE9uZ3ozUkJiYTdrRlE3azFGRkUvUVg0UlhRbi9nRnhT?=
 =?utf-8?B?aXVvaU5aK2lzaFBoSjU2SzdsVlNwQ05iTjRLbEZ2ZUp0Z1NHMkcrODFRcjVY?=
 =?utf-8?B?M3RHbTlxZUtkOCtLRndCSlFtZkZKdWRxcERZZXpNNzJwakZxVjh3aXc3ZmZW?=
 =?utf-8?B?d0JWYmFhNjhkaDBNL0dxb3JGeG9BdGc0RkV3RHNaOHVnS3cwZlozZ1BoZS9w?=
 =?utf-8?B?bGRXcEc5MVZmd3lnVlhhWjdjWEdld0xFY2d3ZzZVYWRlNlBZWVRjNjhZcFMv?=
 =?utf-8?B?b014Z1hKNlE4eGwrTHJmM0dUcDMxUCs5SlJvVEJkRUJvdDNwRjVXT0huS1c5?=
 =?utf-8?B?QVdpYjIwMkNsZFh2Ynk1WDZya085YUVoakxqTXV1U3RwR3RlQk5kSk1PcFlY?=
 =?utf-8?B?WjYxUVRKcHZaZk5WaWx6TTBEenJDRENQcjV1THRqUXNGeUYrb3hQSmZYTElP?=
 =?utf-8?B?WXdXSlVEU2MxV3JOQlZzMExZTmk4N2J2RGthbGVvdngwcHAvVnJaZXhlZ0NU?=
 =?utf-8?B?WlE5eFZrQXF2MEY0ZkYyRUdrcnZuc2Q5RmhoMVFLaHdYbS82cnM4VytYa3Y0?=
 =?utf-8?B?QWZlTDJFclcydDZmWFFGVGovTUhESTJLUWw3NlBXaVhoaWxwVDRCMktJTW1L?=
 =?utf-8?B?SlYxRDhWZ2dhQkRUM3ZNakFZWG4ydEtBZnVROFQzRlFtUkRZSmFTdG1GTExO?=
 =?utf-8?B?ZklUK1creC95YllodGxqT2JLY3lYTFQ5NEJRMWdjZFZDUVIzSktOL3BIM01o?=
 =?utf-8?B?akZYTTZMdHpFYXJiemdPV2RNVEJ3cjhVYmxweDU1TndNaG54dG4wVXc2cjBR?=
 =?utf-8?B?dnF2WHoyT1AvalovcFB3by82cElnZ0l0YzRBNXJoVHhMZ29QNVZVSzhzUWRk?=
 =?utf-8?B?ZldRQ3ZGaEVzQkNTMEQzNU1oYys0Y0JST0hIZjQ0SW02S2l5eGVzYXFKRWNs?=
 =?utf-8?B?cTlKekxOeDZzZ2hpYlFNaDFCS2lZeFlmWWNNNmtOemJ6T0x0TlRMa2psZGNV?=
 =?utf-8?B?ZlpwR1FiMU9sQ3JxVjJldVcxN1FRZWhNZ1F4aHV6YlptaVVpanp2eEk1T044?=
 =?utf-8?B?T3dGK0hsQUJhS0ZKc2V4eWZLemk4OVd1c0dWZUNRSGRva09FSndIdWhqQWxY?=
 =?utf-8?B?d1ZhSGxna3cyTEVVekJoMDdLbFlHNlBDUGRTOTBPNzFBWGNLMFFUUjNiQkox?=
 =?utf-8?B?NERsSTBHdGxQdlVFSFFGbkN5RXZnQXZiQ2pTbVBvT0ZyT3F0ZEtJSFlqUzVC?=
 =?utf-8?Q?uTr9tK0LuajJNORI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a716cdc4-201d-4d70-0b2a-08df2aa0730d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:41:12.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFWipYQPsHK3gdWZx4iJRMQtTJ+C7jROwfumy5JG9H76q35OhGX2Ctr1v73Zxh5nCE7cpjk9xTFP8i2t2aXMAE7HmXI2RoRu7gnFFYHGK94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9824
Received-SPF: pass client-ip=40.107.159.114;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 10/15/26 9:06 AM, Akihiko Odaki wrote:
> On 2026/10/12 19:28, Andrey Drobyshev wrote:
>> v15 -> v16:
>>
>>    * Patch 15:
>>      - replace the errno filtering in vhost_dev_try_release_owner() with
>>        a new 'owner_handed_over' flag in struct vhost_dev.  Release the
>>        ownership only if it was handed over to us, and report any failure;
>>
>>    * Patch 19:
>>      - set 'owner_handed_over' in .post_load() on the CPR target;
>>      - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
>>      - drop Stefano's R-b because of that.
>>
>> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> All comments I raised are now addressed, and other parts of the series 
> also look good to me. For the whole series:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> Regards,
> Akihiko Odaki

Thank you for your time and efforts!

Andrey

