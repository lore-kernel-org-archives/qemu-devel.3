Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD89CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDie2-0005dr-Re; Mon, 05 Oct 2026 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDie1-0005df-U4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:22:17 -0400
Received: from mail-francesouthazon11021095.outbound.protection.outlook.com
 ([40.107.130.95] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDie0-0004La-7M
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL6J42/lXJasHJk9gxbYZKu9c9j/556mQJt7jLOkXbGiMJ+8PiiSNR0oGfFyyxtT1W/4tWBQaK5DmPiOpaChSkpdxoYlRekGbWBM+JgIAq7QWItT8cXehnF1UBeAcQljirBh/xFsVCgGLcdsAVBndH+mi8FXvurMwHW1a3VpNFXLR37Tvwmk0LKbBuJlhzTnfI1nen6ZjG0aGUFvU4REpvqsipaZ2ZIiPvV2fLeTP94MLntQ+2OOajVx7TYdu+ZthnOyZTuNAt1alfHe5Jn4M2ktAqSRpowR+3GLL086nJfg8AFKlkXVkyuK+P/dni+Ug4z7pKxbgAcB6IKUfi4l8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzAkkuzJmsNHzFH7yXVMsnVZs94QVdDTTXlBdqUuhDU=;
 b=xPNIgG1d2UJQbZYhTFRPZW2l54WpgfYCjWgJOjBwL7DbPxd3wAK/ISjVHJJxdHwNj/iUjua6STY+lRjbatK6WmgO9kmGGL/MJUSjkQ8OoHbHEHpXY9rxljnE4LHGjcCU+teopAc5hzLlyp+mEXDqb1UMRFBdv0vn13JL6RNCkn/jEOQUMEkS/7SQJPO/miPiy/dEsBkFG7cAjUNy7B65Y+0UuvOlmbesyF8xM253C6MaE3agZC6l+XQxlBG1is9Nh+shYhJJoC7TS5KfyFGgqF9h+8r925zfxZO+HtOpIcB1EpriukbJblOw24qa0TT6KWQyFTKtuFjQm4PMEtxS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzAkkuzJmsNHzFH7yXVMsnVZs94QVdDTTXlBdqUuhDU=;
 b=qIbgXb+TNOhuHfQiVxwMeJHxOcNZ19tICVhwVkaPJHdPjVf/6no1bNj8p7nNkqf1cacpeiA5huwEjlTz191OMKNgw2F0tsENDuho3+1UaxOhvJ53UQ1U4j0IHdmFbUyIryyVXoU6UpcCFK7A43j6NdA9/bsIWeZFW0hpGfpH+GX3PFbspnCZARTVIG2KE3n6AcrpcDxytqJoK+75WTjrM68lKMU6+BdrLg01UZt3fNIPJy/XspG0D5F0jy5eC8bAXITkZtj+gcaEpj4gQsmu5JZ+Sf2vU+UEhJmKwQwyhz++RAbqbTzNGGV6B6/axoDy7Mdua9dLLswDQKJiuLaAAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5942.eurprd08.prod.outlook.com
 (2603:10a6:20b:29f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 13:17:09 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 13:17:08 +0000
Message-ID: <8d680749-7032-4276-afe5-5b81184641d7@virtuozzo.com>
Date: Mon, 5 Oct 2026 16:17:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 16/19] vhost: release ownership on exit
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, dongli.zhang@oracle.com,
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org,
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org,
 peterx@redhat.com, clg@redhat.com
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
 <20261002-up-vsock-vhost-v5-v11-16-18fa09d8273d@virtuozzo.com>
 <674e4907-1065-42a3-838e-400d369ed28e@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <674e4907-1065-42a3-838e-400d369ed28e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 917b88d6-f682-411a-66d3-08df22e2f56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cxbDxWuyUO9l0qvXF2P4Mnfp6+YASfXp5i5vgz96WlWU93ddyeumpcu9Enz3sbtfZVbj2rtDiG0pYJ5q26KIzaT8KkdloW0M923c6uopuoRSSMnUzwakcLj3KRhe0zLQF5LuJdVUvUkdOzob30BmVg5myk3A8/FMVQke7fQKtD8b6LRRpUpy713cahSM9yZ9OvK+EyDAp7uf+cet0WU8NuSD5ta0/vlf35Ywdx+AMAbHRUppHuBaxFkDHkuhrJfeQZzJPH0UYeTHE0f8EPdgE/lkosByjJhy/XwyVCGsxKRRxjOpdcn9khRokY0/qN28n0YR5q0n+H4dZ0e5jhjXA0r3ftUoC8bcZ0th4scHwnL9f6dQizEJMvxE8wfeAAZJRHYCoFjm/ve+xTjlusWLILF2f4cfQWLIyXwndL9vlrDZsuKwBB+uZaPXkjf6Kcu8JCxFIftqUafAhpDBn66oVficCltLJ2KsT+G5iqXpw1ONOWKw0AGtjwTIcJlybLLuPzsgV3Lfye9OOHngUJaV9YOS+C0/6x+nWQCgWNqFZ6XP76i/SYSwKKc409xkfLSe6uiVoTtw71QB/82V76bEqMfUwLj88tp6aXIgQfaUUgTFbHloqJWXFIe2eTE0D6UQo4J/t8BH85eeOl8zjq1aw/6hH42x/UgPgW9h19OXmUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJjSlY1aFhENEcxQ29XYW42Z1U2enFXR3FEVDRjckdvMHZxczlwWTF5VGxV?=
 =?utf-8?B?N0toRU0vZjdGRVVXallnMmdLVytsTlBXQ2pmL3ZVU2RWUFFJdGpNVkc1SWMz?=
 =?utf-8?B?YnRoMURKcU1sYm1DNGpvc1dpMjdrVlZaWkdSUUw5Y3hKUEh2dXY2ZVZhUW16?=
 =?utf-8?B?emhNcGUxT2ZibW51S2FwODFJcTZuTWwrbFduWlRaSU1kMGF3Q1pWN3NxRTUw?=
 =?utf-8?B?bmM4NzFoRjhpNi9KZVJZMFNmdFh4RTZmYUE4b0ZTMEtvRmFVUmJpakx6Sk9D?=
 =?utf-8?B?Y2pKbUZWM0xRUDhEU0JYN2grUk1MaGRld0tnbFpXMDNveC9DQmY5ekpucW1h?=
 =?utf-8?B?c3prOHJjMHFQVlMzWkxlYWRmbGd2ZWh6RXZwU0hQWUNtSTVpS0wvek9IT2dt?=
 =?utf-8?B?S1hELzRocVc0Vjl6SXFGNTNXYk03d2s5clF3c2dsbkdJQStwQ3ZsV3BLSkR0?=
 =?utf-8?B?N2w2MXdzOXRnV0ViSDhVdFdIbnBSb3ZBNWVDNnFlaTM4L1lpaWJaUUtsL2Vw?=
 =?utf-8?B?TElqNzNtNGhYQnNXekJrc0hHMDJTOUhuN2k4eXhvK2F2bkdkYTU5TGJGRFNH?=
 =?utf-8?B?Tkk0eWk1OGtQS1NIcERLZ2tweVROTzZBMkwxS0dFWll2eGIwSTdKYkRyaUdL?=
 =?utf-8?B?ckRLcndNWDNPbWJkRGNCM2tQb2NXOW5PckJrRmtQZnNBSFpOaWlid3lsMjdu?=
 =?utf-8?B?dmsrVUhwamdQZkdEWnQvMEd3ZitMV2dpeGEralN1bUNxclBDbDUzWFJYVFBB?=
 =?utf-8?B?bHJJWU9YbGNuTWd3dS9iOUpJaHU1am0vcGZCazNMK05TdFAvQnN5ZDlKL0dn?=
 =?utf-8?B?dit3QkcrOTAxY1luRjFxM05KeFdsaGlWc0lKam01R1QvS3h4dVdGL2JnTHlM?=
 =?utf-8?B?d0xHdTBJb3N2TnVuU3dzRUo2bGZ3RGpCVFM3VEp1VG15TWZZT2p1NngrMlJw?=
 =?utf-8?B?d1l1MkhWT3AyZnR1cnNYQ3kvUjBBUmZPdWJTcmFPRHUrNzY1aWlhNk5zME94?=
 =?utf-8?B?L1VDY0g1THMrc1hSRk1pOGtGZVd5ZExSWFF4MzNWUDhMbjkwNUJieEpQUFd4?=
 =?utf-8?B?Z3liYkpSaitSS0JlTklnQXk4ZWppWDhmalF0MS9YOTc5aVZmS3ZIeUhYdHN5?=
 =?utf-8?B?NEg4MG1PUXUwdHJoK1NtdDZzNnowb1Npc0U1NjJTWWJJaFF1R0JaVU5UQjY4?=
 =?utf-8?B?d3dhMmJhdDFKSWFFRkJqYzNSVXQ2emZRM1d2YTVsSStON2RuMDZobEJuUW16?=
 =?utf-8?B?ZDd5b0doS1FLRDlIL2ZEMXF4Tkthc2FvTXp6QzNsWmtYQkNnT1Nncy9udEpj?=
 =?utf-8?B?bTUxamVIVFZtYjUzMHNNL0Y1OGI2OCt1UGU1Q3gzVjdid1hDb1gzcVJPRWFt?=
 =?utf-8?B?YkpmQ296MnlwWGdqYUJPRFNKc1NEaHFiMm5Pc3BIYk4vZi8vYngrYzkrK0p5?=
 =?utf-8?B?WlRNRUNua3F2dGFLWXJqK1lHRTNMdUhmTWZrRlIvdlZUU3l4eXV4VDRsR1Vi?=
 =?utf-8?B?ZU1KaW1ON2NpRmUyYTNjUk45TXM0OFV4K25vVWNrNEMzTElZeGVlNWVvR1oy?=
 =?utf-8?B?eW9QWWo3VzlZN29FdTVoemp5dzlSZlJFZXJxQm1XNDVabEV4VXlXUEVvRWph?=
 =?utf-8?B?a3VoT1RpcUNyblRnTVlTbmlCQ0U2TjF3Uys1cVA2RXV4UFdWODZ1RXV4VVFL?=
 =?utf-8?B?bUlBemRoT3VRZ3ZjRVJUTXpjOThxMW9SRVcvaGEreDZyMXBnL0dKbXplM3dz?=
 =?utf-8?B?RWprWTE5U2hrblYwQ2pkWjdMVURuelo2bVFDM0tvMUY0WmdzYjhtem9wdng3?=
 =?utf-8?B?M1lJbi8wbUYwaHRRa2g0cjA5SEV5c0FXY1lOdUdmZ2Y3RmFsVzYzTEkxdzlT?=
 =?utf-8?B?ZHpaenR0RDk0WU1JN0tvbitLaGxucFM0YmtKK3JIcCtZZmJkU2VybVRINkVF?=
 =?utf-8?B?cUR2VE1BN3NsNzBTT3Y5a3B0enJIclNSRHVOc2E0Z0FkT1V4d1k3L0hVSVQv?=
 =?utf-8?B?SmlhZFlVcDBPV2MrVE1BcUZlLzU1KzhOR0dwUEhVeGdweG9kSTBUNFJHbzM0?=
 =?utf-8?B?SngxMGJleWgrSGM3cUgvSEhjZnI1d3BNVGNmYUhUSnhCOFQ0dXNkU2lSSFRR?=
 =?utf-8?B?ZEM2UGhyZHArVUFyR1EvaXh3bmtuY05UeDZWVllGQXp1RWIwRXlWMFhqTW14?=
 =?utf-8?B?Uy9nZmRsUFA2ZVl3VG1GbkxpZkRLaE00UFBibWVZN3lRV3ZPWVdlaXN3ejF2?=
 =?utf-8?B?QlBna2hkTlBkSnI5UE5nNTNSTHJLaXJSQlZQYmp0VVAydTlobkQ2OUYxLzdE?=
 =?utf-8?B?NG5reitqN01VRXJHdjdrQ0FIN2YreUNwejlyYVJmOFM2YjVHbUpMaVg2a0NI?=
 =?utf-8?Q?Y5oDywOFqXhdS7SE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917b88d6-f682-411a-66d3-08df22e2f56e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:17:08.7364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iN3X0kuTGU4+rSjoy5rC3F4oxorRGkPORm869Y9zBZwILZXnm61yyGoFQIRexbscQuQgf1NPXZbGVizzd/Jz7ktgKQ6I+MwrQtHrSkoaJ9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5942
Received-SPF: pass client-ip=40.107.130.95;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

On 10/2/26 5:53 PM, Akihiko Odaki wrote:
> On 2026/10/02 22:02, Andrey Drobyshev wrote:
>> A CPR target that has taken the device ownership in post_load() doesn't
>> always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
>> truncated migration stream footer, makes QEMU exit() right away, and the
>> ownership stays with the dead process.  The source still holds the FD,
>> so the kernel never releases the device, and the source can't take it
>> back after being resumed -> SET_OWNER fails with EBUSY.
>>
>> Add an exit notifier to each vhost_dev, registered for its lifetime,
>> that releases the ownership if still held.  This covers every orderly
>> exit, which is every failure QEMU detects itself.  A target killed with
>> SIGKILL or crashing still leaves the device unrecoverable.
> 
> With return-path enabled, incoming failure first sends "SHUT" with 
> migrate_send_rp_shut(). The source can automatically resume before the 
> notifier runs, receive EBUSY, and leave vsock stopped while the guest runs.
> 
> Regards,
> Akihiko Odaki

I don't think using 'return-path' buys us much when used with CPR
migration.  However I agree the gap is real.  The way I see it, we might
just register a failure notifier on the target side with
migration_incoming_add_failure_notifier().  That notifier runs before
the exit() path we're fixing in this patch.  And therefore we'll close
both the exit() hole and the 'return-path' hole in one go.

I'll send a respin with this if you don't have any objections.

Thanks,
Andrey

