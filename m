Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3164BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSal-0000YD-5n; Tue, 30 Jun 2026 03:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weSaj-0000Xs-Nm; Tue, 30 Jun 2026 03:09:09 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weSah-0008JY-QS; Tue, 30 Jun 2026 03:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKyuOBisumjFi4WzZPiZOLcEz3wyEHshYdOEIaeoy8VmjBb7V+ybRi/l3N6Fd3sT2i9rjffegVoYR4AvO5eG3JcmHY7wzSNusC5Mb87LNMxBKia/ZW/8cxM24yUd0GRv/gdMaJxfR73IjtGGfIeSvv8uqcq/SXNOq7N9HNyJeNffG29n36ykZhr7Qs5YuG6tVRVPLIL5/j8Z2jdxIn4J2M3jDtumbKVwLU/nUuT/ajBu9Ki8RJSavG0MXSpvwVrksgwDVlqoN12do4RkOQIv/GZ4QGr1vc0SS39v5Z/ETtoQgyNsUR8Artsn9v2Nr2pLuK5629+sWqf2s8sruNzqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB5XzLtQVMhAgCaUCp7HC+UcVcDCdaF8MzpKqOr4qJQ=;
 b=QXSS0kCm0bPpaKmNncrmDMtmJvEEj922S6zVOo4xXM3ajLSp6lc39QOYTQiL11Z0PcSMyS1ndNljoFVWYLoJeyWlx/txvppwPP3Auz5uz5QMnqjoYv7EL0ZABOSuJhyKqdxh6jDhAxZXeQgLQ/ak48xqwgUYyNqGZ5jNdrpD8ko89L9hKkNRdWZmwtuI9Ob76cTdZxPFvdPIDYec+M9JnFynMCOROI4w1leF8SygKMqyBUGDsGOEqD54wCeeT4coKXTOVSxFAglkE5XPFHKBdAcsbdVJ5eQnZn6eIyBQSmDEoLds+pklOQydvescgorK7O8m2tqVhOMiNKm7n/ITfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB5XzLtQVMhAgCaUCp7HC+UcVcDCdaF8MzpKqOr4qJQ=;
 b=f6LkR33oQF1Ry7wfMamE0i8pLuvgIrEK9A8xwO8loF9n+/4mi3OFeGa80jwu9U7MWcznFiQQMIXj3PbBWrAAHHRed2JnVVCAs7Suq0EKF9yT2L11DxI3emEGbeuQD0YSyRhnvQRyUs5UWwo8uxmASDxtN2bl7Kh83AgzW3YmxI3pmQUbKCxUmq8JUxvOSZA5ox98RFlzzU/+Ot77BbfdBLEdgSSeJzjrfGcqYYz4A50Xp9iWgVm6nT7m9Hb3xL85bJZLdbOGheJSRXT0jd8AjcytW+WBOarefTEY5WdAfr8NpeMVj1lWGlJIWovXAxybdjwhvX/li9L3IYVrxdOvHA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB6593.apcprd04.prod.outlook.com (2603:1096:400:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:08:59 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:08:59 +0000
Message-ID: <SE3PR04MB892289A5CDB66EB6083A1456F3F72@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 30 Jun 2026 15:08:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <255b3db7-44eb-4342-ba3e-a8fa1270d51b@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cede8de-f16a-4c67-13a0-08ded676749f
X-MS-Exchange-SLBlob-MailProps: suo+AMQROd7awkY+uqD1IG9kXGqTcr3cGjrnjmQFHPmv85Vtsb8uJXEumYeQz1OEfMWkeOurnSrlOtRCmD/M+FmDvU48/VECzYkY+xh2SoOyp1a5fQwjHg8RWyH+X49Is3XHGr1FEH3BKahvNunLSzXeBt2W/Drjo8oSpoOgHKq54h7ZixURVVE4bDxhUxro0lwuzaAa6ANnK0QmbEI1q4BB3fJ0puxLSxbng/OZJOtNnGaGI0WxWpqz6p5WWuZJlpLwjLw5PSJKt5UDpY/Y1dhuv2aMpf9wQZdapab1zVT5NdkDLj9DTeRSRo53E25rgthq7jRhcYN35/mW0HNPhNqNbUEk4tLVciGG9a6tLw3aHKub1DnxchX8dzCVMp6NEVfmaQ9r8FMokdSRLOPI9tPP+q1YbZT+wM2hF5BW2UDf5+zMqT4cF/f+BR7Izn1tF14G2zWeNlgXAt7b/iFoqlGwpLlPNTjfI6UmM84zk5ZHqjwqXltlT/6Wl0HxFJexmnr+OaeCu4RV3tOqYLPkfCANiNpJPTbIyqr8Wgg18LzCaoWXBGJST+3zF5fhyk1kcLcntBOesKuQNLR8iOJ5M25E/M7YJpI+DY4EQYY+qSFwRFBEHtDMlug2cempUFw+EynJMvrvuy/XlzPDbREPjcJ+BamA8CZpbx7b0tc5LtZHIWEEy/pu+f5/DrGCpVLK/RibkvILsbpLhVRSAJuYpLnPaUvQ6oPVUrfpTjBVN+s3K7mWFooQ5Yud+IRMjZtLv+RGK2nlW8IvB9ZnVt96Yq4ZUUCSUEtj7v6aN2dg8NDsPlPX3SrK2Fs11MIRJJmuXGn4eRV4HF+7bIpPolGuFA==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19101099003|6090799003|55001999006|51005399006|15080799012|19110799012|23021999003|8060799015|5072599009|25010399006|10035399007|40105399003|1602099012|12091999003|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHN5N3hWUTRQL3ZSUERtSm5ubWhpcHRyMkJjeVJ3MGlMV2FhWjBaajg3bTU5?=
 =?utf-8?B?Z012SUhhYkFsWFdSL3pBdHlrWTBobU9oaStxMEVpZ2N1RUpDSjFYVngyWlRL?=
 =?utf-8?B?R0ZjWXg5M0lqVFBqNVNrS1lZZTBhV0k5QmF5L3hNL1RYWE9aSjJlMGVXaURz?=
 =?utf-8?B?aWtCRml3U053TStUZ3lLQWFZRFhHV1VhOWU5UzlMQ1hPdFVBZkxYZ2pjNkxB?=
 =?utf-8?B?Z0lldzFiV0tHRkpUS3V4b3g0a3ViZDc1T2tmV3JYWW9qZEcvSmF6Rmp6ZUNj?=
 =?utf-8?B?VmJNL2Y4TzAwNWVmUUZKTkN4TDkzeDZtV0FUeG1tUDdMZGdUTVcvWnNzMjlx?=
 =?utf-8?B?UFFJSzhZdjhseEhyN3FnTzhqNzA5RitwcWhIL25VL3hUUHE3N29NQVgxbFNN?=
 =?utf-8?B?VWY2Q0pCWTVRNjJTamJlMmhWdGJ2d1VSUnZzS2JTbUp5Tkkvamx2cXVqalRW?=
 =?utf-8?B?YnRCaEdOb3FHOVNjL3RJd2V4eGtFUE01MHptUUNxcU5sdU00ZXhTMnArVk1Y?=
 =?utf-8?B?K0d2WW04SEpGQURuMnpybTBBbEhiTTZOeThkUUE3RXcveXVnb0k2TFNKdWpz?=
 =?utf-8?B?cUZEVFhTUnJtZHJmcWM4VklmRXh4aFFOK21CV0krRHlQY3Q1clU3T2xtSVhs?=
 =?utf-8?B?bWNndi9uMDBva3FPQ1FqaW9zVjdJSFRweHFUR2J5NlpYM2ZsNHlNTDV1TXJV?=
 =?utf-8?B?dWVPTE0vbU00Rmp2cndCa2tFUzEyN2MrOTdwcUdLaUF3ZU1XZVlzYzJyVHJI?=
 =?utf-8?B?VjdHd0NWbDFmU3A4RnpOQWw1QW41cFIvVHp0SDdqdEhobDlQb01EdDF6anZB?=
 =?utf-8?B?cVdKSjdoeGVkZ0NjRkoraG9yTTkvK2dmNGlIMFdMalpqM1Z5RmFoZWk1T0li?=
 =?utf-8?B?Y0IxSmJxczFVaFZKTkxYL0YrWDJUV2FKWGNuMmQwZE9ia0txTHp0alFmdGJx?=
 =?utf-8?B?aTNZMjFkRGhMYkVoOVc1eHMwcFpRc00wVHFJelJZZTdhWFZ4YkhXNUhyL3VZ?=
 =?utf-8?B?cEtXTEYvcGpFZmxrSkFyN3YrRm9LTk1zb2pHY0lrM3FGVUFhZ2paMFdUTjFT?=
 =?utf-8?B?YWRVWUsrQmU0YlBCc01IdU9idHN3NjhzZ1pnUUsyUXBWa2w3S0NNSk1rS1RY?=
 =?utf-8?B?aFhTRlhES2I5Mm1wNWh5VGp1UzkwM0pIZFowMldqVDNqVDUrSXlsNUlwMnpQ?=
 =?utf-8?B?OFpKM2ZxUU5SenFZSlFsdVJXekNyeU1DRVBRREVUOU1CTXZDdzc4U0Q4MlVX?=
 =?utf-8?B?djZpYzBGWW5VcUI3LzllbUp4emU1SlcvdmZyNGVYa0lOQVBVNXVKQ1VmZDR1?=
 =?utf-8?B?QnFLcjl3SEJhUGFqRENtZFhuMlFBY243VWpSZTJqc0RsT3k1cStscFVIYW5X?=
 =?utf-8?B?Nnh1akpsbUZ2QW1XaEtxQmV1Q3BDN3JVbmlpM0dhMCtNZDVBMzAwYmh6bDdm?=
 =?utf-8?B?WlZ5SHNPc2UxZnlCWXlFNjEyVEV2Y0w4Y0pFamQ1K2lKKzBxNzN4OGhwc29a?=
 =?utf-8?Q?4qHWDIBLKXZi/Tao2Lv0Daq84bt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFWVkgxMExsaERTOEtiQko0d0lWKy9rVk5EOUd6M0tHR0VvWHh3NjBvZDhm?=
 =?utf-8?B?cjVlRi9ua2Z3YmluTkx6aklSRUNsd3NqSGhZSkJZc1JwSVlTME4vMkEyV2Fk?=
 =?utf-8?B?bHdlL3BTVGVQUmk5anFFM1cvWnA0Y0RSZ29TN0FhQkxsejVVcXZibE1DWU5G?=
 =?utf-8?B?bFlNOHo0WktqajFValNReitEb1lBYXRkOXQvc1dJbmhHSmZjS2pCZXRIaS9V?=
 =?utf-8?B?VkUvb2VJYTNtNGpUeCtMWVhCUGR1MTdodGRvdFNlSnFVSUkwdm1vVzVVbFJQ?=
 =?utf-8?B?Z0RwOUhuYURyVVRheURDcDc0UVB1MHltQVRnb1J1WEZkbmxkQ2RDZGs2SWsx?=
 =?utf-8?B?TmdDa1c0UmtNSzJOV2xNOFdEQ0I2c3BCa0VqTklHeVR5UStKQmxBZzh2V0kz?=
 =?utf-8?B?OFJmbmx0akNRUndDZDBqNmdZc295N20xcHVaL0FNY215R3p4WXRXUHBkRVVn?=
 =?utf-8?B?RXhwcUFPRUJZTHNBa2pyZ21iV08vcXo0b2dLQ1hEQWZMTnUwT1p2Y1lDQkdT?=
 =?utf-8?B?YW1tWDh4b2ZMUlgya2p5YWk3WmxRdytKcUJQdUxnRjlYOHRzVlVkdlpqUnZl?=
 =?utf-8?B?TDRSdURjTHVqdWVIU3EraWRvcCtZVC82ejA4WHNNZVFyN3FUSTl6SmtpeTda?=
 =?utf-8?B?Ri9nMXozckdKZXlCWU14SHUxa0lFL2tiUlJtWmNKL3k2ZFFJZlE1c1BxT0pE?=
 =?utf-8?B?SC9LemVDMFVORU9rNkZUT1VqdFlKZ0M2US9qU2ZvbG9DNWRLZ0gvbHRCbWFJ?=
 =?utf-8?B?b1RPYndmaHhhWlRxWW9qNWdyR2k0Zit1QytVSkJoNFBaZVJoV1h3cVdpYjFS?=
 =?utf-8?B?Y3ZhamNjSUd1UThGTVRRLzlMc0xEL2JmNEhKN0lJMzRYb0Y3Z1BJbEdyMURw?=
 =?utf-8?B?dmhTZWgzMkpobWpHVElrU3UycmlpYkpYS1MxMjZKbmthUk5VOU14elRpOFE5?=
 =?utf-8?B?UGpia3U5bmdZQWtQNGIvbDBLcEJ5OU9ZUWhBZnJKOFU0bGZMVC84MWFkMWpW?=
 =?utf-8?B?SkRZNEJZcUI5a1JlVTNaeHBVN3ducmVCNmFLNTFEWDJ3TlgrTFhINnhPN3Vm?=
 =?utf-8?B?U3UydVBsanRFMDBzYmNNWGFQK2puZnBsVWw0NGF3MjIvNndWU2Q1ZFVWWnJN?=
 =?utf-8?B?aXNPakFBU2txK0ExOVoxTCtpdjhKa25HL0Nlcks5YTY5WHpOYTJBc3phdjB1?=
 =?utf-8?B?WFhmVUJuOEVtdkFMRENTa3l3RzBsSWlYUDd4bks5UXYwMm5ZVmhMLzdiMHNy?=
 =?utf-8?B?TjJURU41ZXJzaFl5TzM5NTNwa3NZNitXVTJDaDVmVnlsS0dtWm9PaHFIVDRU?=
 =?utf-8?B?dmdraDNCL2p5ekNnSGpVbzhIMzh1SE41WVFFNVZUM0VFZitjKy9Zc3ZxMjY0?=
 =?utf-8?B?c016a2h2REZMc2VpRHVQb2lURjk1S2RWblNBTUVObmpvZEdMSG96RXZFLzVG?=
 =?utf-8?B?MEllbTdPMkJ4S21zd3ExakM2OEZRWWt3WStEM1JKUDR3b2lWT0VzTGYxeTQ2?=
 =?utf-8?B?Z0FEWFFteHRab0k1MlRKQ0JBWnlUZU5BVUE2d2FEZkNmVmRaWkFKZEJCV0VJ?=
 =?utf-8?B?bkxXUFhacWdLck92U0UrRzJtV2xab1h2SER5dlVkaFVsVlA1Ni9VUlJKZ0JW?=
 =?utf-8?B?MXMzWktWcjh4aW55MzM4bTdRODJhQWIwVWNYOXk3UFlzU3VmNkMxam16UmZm?=
 =?utf-8?B?WFVWWC8vaXRNbWNEUHRtTmxMMGp2SEo1VEVKcUNOQUJhZmNwSWtaaFB5S0pz?=
 =?utf-8?B?MmxnZFJ2eVpWNEFiZXlaczB4dTcxemVYVzN5NGgyYjQ5bnhkVmVzMjZWTnFF?=
 =?utf-8?B?MHpKWTU3RngvL25Gblh2WHVlRTlNVXdnNVczK01Qc2xTTHBkUGZuaUxtQ1ZL?=
 =?utf-8?Q?j0lqKAnMIHWsw?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cede8de-f16a-4c67-13a0-08ded676749f
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:08:59.3657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6593
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/29/2026 8:57 PM, Daniel Henrique Barboza wrote:
> We need to throw an MSI_MISCONFIGURED error when any of the reserved PTE
> bits (first doubleword only) are set.
>
> Fixes: Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3563
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..6828349fe3 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -648,6 +648,27 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>   
>       switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
>       case RISCV_IOMMU_MSI_PTE_M_BASIC:
> +        /*
> +         * riscv-iommu spec MSI PTE basic translate mode:
> +         * "When an MSI PTE has fields V = 1, C = 0, and M = 3
> +         *  (basic translate mode), the PTE's complete format is:
> +         *  First doubleword:  bit 63      C, = 0
> +         *                     bits 53:10  PPN
> +         *                     bits 2:1    M, = 3
> +         *                     bit 0       V, = 1
> +         *  All other bits of the first doubleword are reserved
> +         *  and must be set to zeros by software.  The second
> +         *  doubleword is ignored by an IOMMU so is free for
> +         *  software to use."
> +         *
> +         * In other words, bits 62:54 and 9:3 of pte[0] are reserved.
> +         */
> +        if (pte[0] & (GENMASK_ULL(62, 54) | GENMASK_ULL(9, 3))) {
> +            res = MEMTX_DECODE_ERROR;
> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> +            goto err;
> +        }
> +
>           /* MSI Pass-through mode */
>           addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
>   

