Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7711CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMXEm-0004SH-Oj; Mon, 11 May 2026 16:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wMXEk-0004R6-E8; Mon, 11 May 2026 16:28:22 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wMXEi-0004lZ-Tl; Mon, 11 May 2026 16:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g978tvwsDCTRFMmgtpXWztpfnsA99S6OFcdo1xVYFJaiOJxqkZ4stYXFZHSWF7ef8RsXCxDyMZeIBJBM0mQOEEaAVXQlsLmI863NCYb4eEZDFV55ySCpn3N3/mD4RUpEtOTtUnoAC1jWZVyNM5aF3S8AnG8tfA4T9AFmB0n4HgOqZfQsLYsk2ExbYDW9/18ijZP8B4PSSAaHKHPuQyIVnKKv5BABAQmMwx0fvX/3IsUrcKkPQGZ4AjknQaZ9FOsdiK/4NY28m4x5VLZPKEUZgnMRP6gb7Vr3s2TVZPSp5QkH+r85d3lkUkJQj9yzZFnvVM3/Nc3ixzKc7C6G8qjmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zt8ErBavkMm9c3KG/D3DFFVI+17g0H7C3d/VwYh4zQ=;
 b=cQPrS9qHNuDkCYSr50x+BO4sV3kdlGpZ3lLy1R08LnwSDhzak1aKlhWLgx4EJz9zjTNR3fvY7JVn6SEU+HBpjbRdJDvk1L/k1FItTP7ibkX9DUm6k12J6JaoK+hludQGUaCOyLr7qmkzBsu4oWMMJ2G7F5GFMF0i0XxlJnOyDkHrpV2Rp1RGiS4uE0IQA0EQGAmEM9EStDbhkXFZQMZISSZezYJ9QYXKTueAFUvKcyl0WAAEBSf77TImFdwmPQUPP+k385162ROgSv+W1JnZQMeGiQcGqktcoLfRDqhx3qQMkkVnwFtD5q31CJMBNPZzjWdXdAfgp5nYz8FXyqgMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zt8ErBavkMm9c3KG/D3DFFVI+17g0H7C3d/VwYh4zQ=;
 b=Tqy0EDH0rnnRm5T8+nNO6yE+/nChAmFvZpcdwfTrO+LJ4BglP1k1fobd2y145noRQxgzQXgt5W5tGQ/vFZRgWS4keFEiKmhn9XHXhaUaEHFu1VAwt+vcU5IO2AcOckarlk8svhsxwwvmZtLdlDW5tzBdsigsaAs/PH16Wv9dE7ujNEklz++La/GmaMrp8XjrUHOz86X9iooMaKTfZ0r9MSS9gc3SD9sI8z20FjGQkkdB2EeKIb8g0KcienyBD4gFzsLaz6BCxG9sarLUgDqUmgh3JkmWahmgjelbA30rEuD3ZM2YuprmprttxGV5A0zXD1ZYIZSlNeAqtAyoSrY1SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 20:28:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:28:12 +0000
Date: Mon, 11 May 2026 17:28:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Tushar Dave <tdave@nvidia.com>, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
Message-ID: <20260511202811.GF1116784@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <CAFEAcA9KxUF6c555Q_Kqn_NVE3z1ojr91+KuatYudj_T4GjbxA@mail.gmail.com>
 <20260511122633.GE1116784@nvidia.com>
 <D6827AC4-0852-4068-A1A8-111EBDF957CC@unpredictable.fr>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6827AC4-0852-4068-A1A8-111EBDF957CC@unpredictable.fr>
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: 529205f4-c522-4184-a478-08deaf9bd2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GpykXpgTC65B1p+cEWhBf1dd1x/+ke42y206hSIYfz9LIS0dhBjOFAlieIuh3xUvGPhF8Kr2RPgQW3NudxrgZSFrkCik98UKp9SuypaseEr8LZCaXizR6dIxyKqXSETdcvlBNhGBRyaImFxQDAAgKrR7oVUTdAJQVkGKCRL3URv1CftBC2jvlc/v/BzDOS56F94UgDDcUWzQVAy8VLaC3ZcvIDE1Tqa2/h7Dof1fOGTa5NOcN0ja7cR/T7dLDDeKHtYCYqxYTgLTfAY/fodfhGx4QyxP7eSB2qHvPFBbb2mInlfBsEo3eYWVfw5+33Lg7PMvuodzlVlwMmzxegYx5p/+DNRA6rvccSH32y1V7zNnw/SORyTMwI5Jee4PseODxlJcnnDWANAHURO2ncP+NJCY2/1G6u8aiv9zdfmEDy0QCSpuSpmRxtxNCM85w0LUVQUbu44h7pidTgvN+Lj1E5Fr9VF/ry55A+Im/ynuG5/w1bOBpyemp69U1aoCIroZFDWLjmt19AKmUvDi4qyXp+u4564n9qZhezKmyFUShQl+X4zplGcgYHsZEAMQaa91b3HHmgDMfivtzwTkl5fFHOMG/+2hY/kx6Wazc+bIRN475PCs2p1HgJYUKoteTlCYF6gaSYqdz3g9AzavV07jhQ0y0dHUOyJKwIjOATEgeRomfKsEvLvq97uGbaHKZS6P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBTeVk2MHM0aXk0NlAwUGFwM1g5ZXNreldBRDFpQ3ZlbTBwa2dTOFFIaklr?=
 =?utf-8?B?M3EvQTFTeHhHZ3REK2xncHJwVDBvQzQyQTd4aXhrRHc4eHNHVkltMkd0aXNr?=
 =?utf-8?B?ZSs0NktPMUdDSnZ3ZlRNcEdwTlJyNDN0d0ovbEFtNXpReG9mTHYrTzhtTytn?=
 =?utf-8?B?RFJwVm0yLzRENTBLOHhNWmdVQlpjYmYxOUhiSWgwQWVJeWZYYXBJbTFINllU?=
 =?utf-8?B?bXY1R2d3S2hrRU44VTk2YzRIa1ZJd0IyTFNPZkdVT2N5WldMeFpTdUJkMjh4?=
 =?utf-8?B?cVRkcUp1U1BlaGtaQ1N3R012dGNsaU53VmdZb3ZCV0gxUXgyaytNQVkvOWZn?=
 =?utf-8?B?QWNJM0VENmY2SDVvdTZJRkRqc3hSTGkvYXRWR3IyRWdDeUVvYnlISmh2S2hC?=
 =?utf-8?B?VjVlTlNvenMzQkxqUzdZdS9nTnk2UEZNUkxxSjBQVEY4QnM5L2k3cE5vWEdj?=
 =?utf-8?B?K1FuMHlra252L01aeGhkWDU0MS9IdmswMUhSSWFteHJRMko1QVdxakpFRVcw?=
 =?utf-8?B?NzVqL2dRcXordTdWd29JSVFDTzVIN1NObVFHbkRlUjY1NDdjbE1FTmkyNlRH?=
 =?utf-8?B?MEw5WG9vSjlOZ1ZlR0dtTXBzaEU2VWxlSFArS1R4VDlqTWZQVFJ5ZkZubVQ4?=
 =?utf-8?B?NXNTb1Q3VzhYaTRJUnZnTmhwMDNhMXZsaDFERHhCelY5c1hzaEM4L0gzbEo0?=
 =?utf-8?B?a0ZqN0JjUHFqemtIbElLWXdKUFdCY1Nhcy9WZ3RVdXN6ODlsS1JULythR3dU?=
 =?utf-8?B?N0RBbWFCZFdZTjVMSDR3U0lQOWp0K2FrR3M0Z25rdHZDdE96VUZmcWRDVytx?=
 =?utf-8?B?Uzk4SXhaZGNhSjJML1pLcWFRWUlSai83OXdUOElwSnNNS1dNcGtZbDlQandT?=
 =?utf-8?B?NisrbDJ1anJYRXh0emxreFF6YTVLWUlueStMU2l2c0hxZWhnMUk2aWo0K0lG?=
 =?utf-8?B?N0tjR0FtdVBFUEZKWkdkaGZZeUE5WTdMUVRkWC92UThtaFp1VkZIeFlKOS95?=
 =?utf-8?B?ZWV0a1J4L1VVb2xVUkg3QStKaWJTUVB5bHd0bHNCOU1wRmNHanA1QjduUHZK?=
 =?utf-8?B?dWVWTkN4cmQ4L2tiYS9taC9nbm1WQ1Y0VUlPZ2x5bFZ0TTJraEFCQTNiT1p1?=
 =?utf-8?B?aDNZb0FsZ3puOHB2Z3FuTUt3VUNBd3NuQmdVWmtuOE5maWtNYURDaEJxc0Iy?=
 =?utf-8?B?UG9oZ1V4SzZuWW5pamhhY3VtaGZRTHl1c1ArMlZKTHFUTkNUN3VVRDZRaytF?=
 =?utf-8?B?bHRSQ3Y1bnF2VFVUalljSUtTYSs4ZloyMGNIZE1FcXJRK2NxVzQ5RWxFOVVU?=
 =?utf-8?B?NEJ5U1Q1U3VYc1BmbHZwS0Vta3NXSitjaTFIV0xSSHA1ZkdSaUgwM1pBMlVu?=
 =?utf-8?B?c25DVjBTTTZia3FCSVZGd0JsKzArMnN2ell3Tlg1YnQrVEh1WlZCakg5Mkxh?=
 =?utf-8?B?YUpmRW5PelV2ZFpsWVRqQTZOczYrK2ErenFlM1U3NmN4TUlsOEk2V1RPVWJk?=
 =?utf-8?B?ZUdQM1BZSlkwV1NjTXBvRithd2NTNGxpa1JGQ0pQWUV3bWp3dWx3SUhHUUtD?=
 =?utf-8?B?TW42bk43MER4Mk9rQ0JaZlovaTczNFRLbEF3RFlsd1VmWmxUNFFPaGxjS1lJ?=
 =?utf-8?B?S2tuS1hHV0hyR1pia2x1VTBGd3U2MjlxQm5peUNaUUdFR1RIaE14cWNLdzVD?=
 =?utf-8?B?aEJtcWNLN3UzcjJ3YkZkSDhvczJvdWJvKzk4Smh1VEFTLzRVUERpMmFNMUti?=
 =?utf-8?B?UnBrenZhRkVmN00zd1RvaXAvaDZVNEppRUZ3enptNVpuTDZEQlJMYTFKcEgx?=
 =?utf-8?B?b2ZpZldqS3VTR3BzbkhINFJ6Q0twaHE0WndieHYvcEZDS3NrV1M5RHB5MUdO?=
 =?utf-8?B?YmtwNUJCL3krOFdKR2hLRWpRdlJNK0pSTkJ5eXN1M2t6eDBjdTRJc2pvODdk?=
 =?utf-8?B?MmlwYjdXVWZDdCt1RStzZXNFVnNZUXJFblBhOG9PS1E4eEFlMTZzQ2x6ZktP?=
 =?utf-8?B?NVJsb3F3S1BYQXAyV2krWEhSUlRSQWVsY0dKMDhmY2FUL2dlQmUwblZTTUdZ?=
 =?utf-8?B?WFdEQ1FsTDVkNnVMQ2ozaTFOT2FTeVlUdkxzSjBydWZKRTZMWDg0UlFTU0RE?=
 =?utf-8?B?eWF6M2JKUENISUhMczh4VXNUT2VkQmlwdEwvWkpiOHlKK1N3amx6VWhzRmg3?=
 =?utf-8?B?S2ViZEw1K0MvTVZESjhieVZnSHlRT0cvbHJBSFVHRW1QTTBSeUtLQjhLemt1?=
 =?utf-8?B?bjNqQUE1ZVQ1eGJvTElRcVFWTkpITUZpMmRHalpUM2UxZ3B1NS82akF5RHJ4?=
 =?utf-8?Q?PjrHPLe7KJCOkNL/Rh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529205f4-c522-4184-a478-08deaf9bd2f0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:28:12.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI0mei9DSnWOdL15dQAC1ZX/SRXsCQKCIScXBuzoy8nF2XsLluMiTV9cFYvbJPi3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=jgg@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Mon, May 11, 2026 at 08:38:44PM +0200, Mohamed Mediouni wrote:

> And not very relevant to Grace + GPU systems specifically, but any hopes of live
> migration support are lost outside of very awkward placement trickery when using
> this to match host addresses.

I think live migration is still possible, it does further limit
migration pairs to ones with identical physical topology though.

> Is this specific to the NIC attached directly to the GPU (that is
> then attached over C2C) configuration?

Something like that, it is convoluted.

> Using PCIe passthrough with ATS disabled doesn’t sound like such a great idea
> on the security side of things imo.

The platform was specifically designed in a way that this is
secure. Yes it is not a great idea in general but with careful choices
it can be made safe.

Jason

