Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B261ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDbyh-0006ya-HP; Tue, 28 Oct 2025 01:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vDayI-00086G-2X; Tue, 28 Oct 2025 00:06:10 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1vDayF-00076f-Fy; Tue, 28 Oct 2025 00:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3X8YdkTxGhErZH0EswLkxMf5XJb99Nk+2LElMIS6JVmCMa4OLTVYOohUfk1YOmIVUQIDU0KthI2LC+WLYGtojFpkXM4wX5GTItuhjXO46NXbimkkuoIMBJziN0hAby7Lt/KTzhVNsZD5+KdB8UWNPKSCR8omV+UKihv5BpZQ868OjJ3OPH/YlifnlI+vokeuC6nT82Al69PBnph2w3T97eamcTFGOWVLPHZaoyDq4tjoXFIwopd2BMj/WVgs1QBbCvMjZFhBfdrPrB755kNXaWq7i4//6dWh06GBdmeBvzyJgbufTjkgI4YrdzuWoicUFsv5t/IvrfetbddLuOutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQR3rQcyPjPNvbSj+YC2RnqCPKgIQFxlMOhs9Hl2Pvg=;
 b=kav4poWUp8QsQyFxHVuBjg/2zwtEoKW/mminaYDspumPQHw654g1cmxv6IvbHuJvFFoMEoaxaiTtzqG4XOQ8TrMCYNrvDONviFwlm0KbwqJG/Bg72ThImbRGKeki4AADnQPVzw/MF4+rb5gWwsyMK8ktkAuP6sn9Y+7VuJMoo95vKmxuU6BNFXXZD8Nqxdk+LKPDbYcVPgIfg17NIu+OPApS8tdZvo9wLSFXjcoHLf8RSrd5viqbzS1L2MhdzqGBM9kxsl00E0N9rqOZhAOC8bUIwXoScU2ntuchdgYVsNGfZfcfItYA1ErmN+hZ4Mx9HIjoSHsO+5OmDB0P1txxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQR3rQcyPjPNvbSj+YC2RnqCPKgIQFxlMOhs9Hl2Pvg=;
 b=Diyk4dOrCGtzeoclVZFv9gqGRM/A0w7X/PDtXcHnfsMhPkVLp6BfH8K5junJXok0f9G7oCc1IsAHj/2+oPxrHlDclbmwBhM3/ZW4oUzZgIUIJAQY4g3D3hBPBkzkl/V3I4yuCH1SEZpXVcuINWUTfYlGrEe2yscdiU2y5JTULCj+ViKK9ISd8WjRb/aVKNyqriTtk8iHUgU8Wg0CFPiSwKHbcEQ0W4UAg8TvoLV12zmS7X5dMMwp0wbh9xrKxDrnEBJY9J9OmrZ7eDy38WCWKcdIrvsipFnjAYopSzu4I3ixxKS7c4ePl2uAXsxP8uxzz/Jx8Eo4Fpa+9245kC6YoA==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by TYSPR04MB7504.apcprd04.prod.outlook.com (2603:1096:400:466::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 04:05:59 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::3c38:c065:daf4:cbfa%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 04:05:59 +0000
Message-ID: <KUZPR04MB926540667B7D2C927E13FD88F3FDA@KUZPR04MB9265.apcprd04.prod.outlook.com>
Date: Tue, 28 Oct 2025 12:05:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/riscv64/test_sifive_u: Remove unused
 import statement
To: Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20251027112803.54564-1-thuth@redhat.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20251027112803.54564-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
X-Microsoft-Original-Message-ID: <81f4c231-2386-4e2d-81b8-0985151be1d3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB9265:EE_|TYSPR04MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6c0be2-26e3-4e03-f347-08de15d74cef
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|11091999009|19110799012|37102599003|15080799012|23021999003|461199028|5072599009|8060799015|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?empaU2FMT2tLRVA4QlB2TjBJMys3bkltK3RNYTFpSVNBdUM0elR1aElzV0Vh?=
 =?utf-8?B?SGZNQnBoYXlta0ZteDg1bEkxd0RvbTFSUURSZkpDaTVDWk05QjRrRm5peGNP?=
 =?utf-8?B?VDVROWpUREU2UExieFJoY1VnMzFOK0pQZHR4S0Jka3FlenM5OTUxTHUwL0Q2?=
 =?utf-8?B?M3U4LzVORG9VaEVocDVBZHY3eDJHd0paeE9RY3c4SER2YVlmSFlQMjB4Tlpx?=
 =?utf-8?B?ZG81ODNOVVo4REFEdmNidU1kZHpYUnZZTGQ3WGtwNHZ3YitnM2JOZTJkQzFG?=
 =?utf-8?B?cndHN2JiNGdQcHVoblcyZUFIQ1RmUEh0K0hxT05VcTkreFo0clcrVmlPdENS?=
 =?utf-8?B?REd2SkNhVEpTcTZRQXY0a1hhc0Q5Y2xqK0ZBTGpTbnpwam1odG8zRll5a1lq?=
 =?utf-8?B?ZmtXTWZOTCtLVUkzOGJkYjQ1WnFxYWg5QkFaTDU1N0wzLzZiWUZmMThsWjRv?=
 =?utf-8?B?emxWSVc5cVhKR0hWaVVrNTR1b20zWVRCRUplbW9mZ013eGR6NExJL2pMOUlK?=
 =?utf-8?B?K2FTUGV5SUIzTlVhRUU3YmRHbXVHN0FBd3dtazkvTlM3TkM1QlVZRmZMK3pH?=
 =?utf-8?B?bmhadk9ibE5nUnZQQjRyMXJUSDhHekFkeEIybDhsZXVnT25qckR6WHhpSEZk?=
 =?utf-8?B?ZjYvWWNrZ2FxNmZDRTJYTW9YeEZhZFNjRzhkTTV0dXI5dTlaOGwySmV0SXc1?=
 =?utf-8?B?cjNqVW9qQklMTnBTSDJ5SldnNU5RSHFRaFd1STRVZFl6RlNMMHZ0TEx3Mmkr?=
 =?utf-8?B?Z0FydUljbkdLOFVTdHRYaFpRNk5hV3pRQWhTTE5HUmR1bkxhckwvd2hRL2hl?=
 =?utf-8?B?OXNERTlCaFg0bEozdG5Ha2dhbmdEcWdBc3VhUEtIdDRBS2V2L3prSUZtWEcz?=
 =?utf-8?B?WEJBNUNJSXo3Zkp1L0F3YzcyRzBvclFjUEI0YVlEKzNBV0lIa2piR1dxQm5r?=
 =?utf-8?B?emQ3Vm9TdTZzR1JOUStJajRTYnlwMjJxcVlaR0YzUFRWQmFsVjYyd1ZmUzBR?=
 =?utf-8?B?V3UyTVhXUkxTUy9nd25DMklrN0RwcEpML1RxQnY1WkNvWVgxVUVMU3BNbGVu?=
 =?utf-8?B?KzNYeW5QVlcxdy9DTHMzYWx1SElQN3dSaW80Q28rVk1qalpGSnplM1N5S0Nu?=
 =?utf-8?B?N3Nuc3puRGNVWUJ5T0IwaFVDWDhJV1F2a1g1S0pqakNBMHNKd2dFMHhoRGtB?=
 =?utf-8?B?U1RZK0FrbzlaOEFrUHl3S2lGTTFQU25nTEdtMzEyNGEyV21Ua1R1TWVJS3lL?=
 =?utf-8?B?cURZNXhHK1AxY2lPMm9ESmJITHVmcFd2YXJJRG16eksxR2dxdy9lVWpYVGtP?=
 =?utf-8?B?KzJnNVRPVnRJNzVoMU84VEc5aEtYWnVPT0RZSXF4Z3l2WDlhYWhQZXdQL3BK?=
 =?utf-8?B?dHBHZytwT05CMEo4bkUxcURHS3E4RjFBMzdnM1Fsd0RXOHlYc21majVmaDQ5?=
 =?utf-8?B?MHI5aEFOeHhjREgrSmN2Z05JbS9YUTVPSStNNHk5SkE2TzVDZXc3RUVRbFB1?=
 =?utf-8?B?dlVMd3dGT3NvaFB1OHhCRHBobmxYK0w2T0tWRkhGeUVDU2s4c2dkUC9JOG9F?=
 =?utf-8?B?OTY4QTQwdUd0cXVTYTJlZFBQQjY5dkFaTjVHRUU2SmVFS015bWlyaEsxekpN?=
 =?utf-8?Q?wFXjSpjgr2+KlLmqZnm9iGe1BMPahuGMUWWs8IeloclU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTBRdDlaOFRTVW12NFpIdGJJT2ZUa1ZiM3FRV1NFNnBZalUwQ2FXS2lZKzE1?=
 =?utf-8?B?aWRNdUNNWUpGa2ZLYkhyN3AwZ0ViTEl3MFdpVkE3eWg5TEZ4UFlCR2xTaEJa?=
 =?utf-8?B?SHJhMTNvREhDYWp2QnFuS3JGcFpWYitsaW9ONnBjNzdubFF2c2E5WG11OWww?=
 =?utf-8?B?dk1BNlFuWlh6R0NhNSt2REV6NmJLTUNtZmJ6bEQza3VxbjZBejRrNm1VVzVJ?=
 =?utf-8?B?enNaU2VzWkFxYVR3VkoyQnBBVGNsYytHN3hzQTFWVk5Tc25DQXFieHZ5ZFVM?=
 =?utf-8?B?U0FRUEl0RDJyQ0ZkNHkxZ28rem50Z2E5RUg2MjFyYjRtektpN3orU05HQnFa?=
 =?utf-8?B?cmJiTjlRK2JyM2s4aWFSQXVQcVBsSUlyaERDWWlWRWZQeTBod3YwZ3dvR0Q0?=
 =?utf-8?B?OEZLSC9pejI3T09DSE5PUjhKbUNzTm5QZDVnUTB1WkdzblpYNW1tL3d5UkEz?=
 =?utf-8?B?amI4cnVVTkNhZDBTT2kvYmhKN0lkd2ErdmI5Z3hHWEtaTE5LMlptU0xvZWla?=
 =?utf-8?B?Qk9ITmRkbUs2VzM5OEtKemlwZWtRS2JyTWZHcmhIMFkzb1dmRFcyVHBjeVlC?=
 =?utf-8?B?RHltQ0dVOUVITkZVMGxFL3NPUVVkNWRmYk9YM2loTFZ4UVJnK1ArUjJKbVFu?=
 =?utf-8?B?MThaL1V1cTF6aG5QNlpKeTZVQUY2Z0ZlVDFOSmN5VGhUMGliaWZBVndCQ0Vp?=
 =?utf-8?B?WnhrWE41TUFtSiszc3BNa2FBeWg5YzlXTHZOOUVEVVk2d1htUkFlVVRTMHNT?=
 =?utf-8?B?VkpicExvZEtJbXZyMnFYR2FHNzdtWGcxa29TTk9nMUd1Nm1JVVBDdU9Famln?=
 =?utf-8?B?R3NhY0Fxd0cydEtpSTVkeWVrd2VjUzNVVUVVTFFid3F6anorMlF6NWY0eTBv?=
 =?utf-8?B?M2dacXE2YnAvV1JpUFloT3g0OWlDOE8wUUVPVURhM1lITGZ1Y0o4RlcrRVlh?=
 =?utf-8?B?clNwN3NSWGVGV2c2cTFDRTV5NGEvZm5mWm02Tis4S2VQUGo1bWhVZUdHSGcr?=
 =?utf-8?B?ZVNMQUMyZ1lTWmpFZ1hDZ2tYUU80eVVLcXBXaHEyOXdmTHJRSXliWjdra1Rw?=
 =?utf-8?B?RGJEV1EzeC9EM3RGWnJVWit2OTlZdFRYTmtBSlZxZy9VSDY5QkNYN3Y3RHQ2?=
 =?utf-8?B?cm9ld2JTWnJ2TmVDaHRWcUVlcWJWcHBZdjN3Rmx6VnBUaytZbGFLTTVmL1Zx?=
 =?utf-8?B?NmJaUlp2VXJQbS9KNTFNczYxc2V5OW9DN2sxaXZQcEdOZDNjbDlJRExrdnMv?=
 =?utf-8?B?dnFBQ1M5NlpJK1phMFY4VGQwNlg4TUQ0LzlvaElRbk5mWUdKVkpOUG5JWEty?=
 =?utf-8?B?NXFrM2JTbStaZmhOMmloSjR5bWczeWxwZmJkTlJ4dEljcHBBWnR6QmZoWHNE?=
 =?utf-8?B?MXVoMXcyVjM5L25XOFp6STV5ZkpiUEdwcENFUm9DNDhRV2QzcHBKM3Q3dmNK?=
 =?utf-8?B?dWNSVXoxKzkyU09jSkpZTktYT3UvbnJWK2pyVEtUUmUySnJoOTJOcW1zRXJM?=
 =?utf-8?B?dGRITTRRUjF6cHhLaVE3MUdLckZBZ1JsMkZBSTI3WVhOeEJEMkRrWjJIcmVY?=
 =?utf-8?B?emxpdEpCTFRyY2QwWEcxR1c1Y0dCRUxLcWN0SnpLSkFrem1MenRFMmRqaGdl?=
 =?utf-8?Q?TXuQ5z7h8GoksTiLo7qT450O/xGqFJX3xjR/Od8euxkk=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-38779.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6c0be2-26e3-4e03-f347-08de15d74cef
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 04:05:58.8105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7504
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Oct 2025 01:10:36 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/27/2025 7:28 PM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> skipIfMissingCommands is not used here, remove the import to silence
> a pylint warning for this file.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/riscv64/test_sifive_u.py | 1 -
>   1 file changed, 1 deletion(-)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty

