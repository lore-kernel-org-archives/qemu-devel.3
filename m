Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4380606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F98+o2cb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvc-0007Bw-6P; Fri, 30 Oct 2026 17:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMtva-0007Bk-I1; Fri, 30 Oct 2026 17:14:22 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMtvX-0007o4-Um; Fri, 30 Oct 2026 17:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwoVYq0nxwQCpNgjjOA/vaYMc10YtKMvSc6mkhE27CxuGsNXSopkLBj8K4YB1GTpz1BiKBdkthcP22Qn4ohUzjpexI2XleVllnJYEnCXHouoNAwpGoO9FRRpiSsZZ/U+dEr3bOJBwG+LOes3D6MeXAchMTPE93wWMe/ahSeW6/hKU6xEtiUzxotr+WWiu4KBPamK+nv0+G8C0tRGBGF8XctjvNHrmcR1rM0cUupNMlEUJZyLzkMAH3Xy4cogqSM4bnQaLnyq4i/v119VcQOBXBeptE7+9s2ETahLIOZgodESro2r36de5xMkch+5Y68kT1V/nPBu5vgeaxr73A0g6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvotAb8MQZ+rLcjcHlaON/WypckF5YtUuVgnNgQLfrk=;
 b=o6CTV8g2E15atdQK4P5JwfaEj75leZ6WE0/0+GgSwr8vhxBuuM8CojdNviXwvif7IfK+qWh55LodfzJferNBHb7rUgNA3f7zWqnniMn1teW139xwW6vI3FEY+sPC2/aS73nAsTCPu12wNakmYltGT8scUHttPbOIfEwa0h92LTejeidoc8e2vaPdz++raqFCAYV2/C3hTyEilxjGb+ikitP7j8a0Cnsnkl0FGCOUXVpntRhkbmTv34bDMvMuNtinHgGq0Rr8vs5jaY+PnoCQiJEI9+x8JV4vE4GZSMDVeZptSU+pAf4n8hDzJLEMH889K+uG75lUrC31OEir9BwqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvotAb8MQZ+rLcjcHlaON/WypckF5YtUuVgnNgQLfrk=;
 b=F98+o2cb0yYAco0RwEhiQeIHjLV4yDxn48aYD0CjbOzvs+waJJA7qKfz+pqlWkc49QRsmMMM5e2L9JOSnUj0oXwsy6ra9O1hXhzE3CVXVmDTH6rtvN8/59XCJgG9xT/ECbUliREmz4wyJS6Yoq5rsPDrPBdcS/ncfksRWOBdSua3Oh/RjYdaMesJa9iCKT2q1qKcAyzIDa4+NFHkvAvatK6Qha1pXV14iu9lFb1HS/28uqiBnwmbdkpGmuuvkzWeIjQ0Nt6u59RBjx2cQW2E3tOLpdeSgG2wNsiw17Lr15JkW3R/GCsTxkowF+hub7azTZUFaWBTDHvIdGugDTlQrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by DS7PR12MB8347.namprd12.prod.outlook.com
 (2603:10b6:8:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:14:09 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:14:09 +0000
Message-ID: <311cbbb4-d314-4f4b-acf1-105b177f88db@nvidia.com>
Date: Fri, 30 Oct 2026 16:14:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pci: add validation for fixed BAR configuration
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alwilliamson@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-3-tdave@nvidia.com>
 <SJ0PR12MB86142EC759980E479AF528CDAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB86142EC759980E479AF528CDAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::8) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: b012bf65-4bca-4e96-2bfd-08df36cabd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|261026121527099003|260925022911599003|260925021911599003|260925021311599003|11063799006|5023799004|4143699003|56012099006|261022113327099003|261009223027099003|261022105027099003|10067099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: zD1sMiJVfeJU4Nkr+fbWjQfUAiX23IEvYJwPibWS6qOi6YCti6hAkKZJaHyKvk0Q/Bx0lKi7wA0XUIU4/VttoXkzOYN6X1px0liXvD95ZsCqrngA8Yg3CLfgplHHO/2CPtNZUHUuGL54SaUGfsH2rYJhDNRVNnawBhTz8jx8/wW5IaTc3bMEOr9Pt1IyPq/tKwjdphucElCOQSOdzeGyrp8uVQGsEDl5vC9ukX2eV3U7wFtENWVz3GuHvs5vzZrjkF3Jf6KVUbSHZnmqfON3MPoNfR3g/fl0RWa51W0KSU8qq7E7RKGZ1+ZJ9XkkxE8NxSL357OPzQotVrlMMXe1Nrlh67ezZZEBYLN+h5jSFd7KoWz4bjZLe4TEVOVgkHdbwT1uTcIDI5jcU+xH8ldxoFJAm2jybVy7nQJYLbICOlfxBiLnQc3YLEamf1JTJc2kkb7xwMhqczbHXQuhXO1bWPCk/auWkpLbGKnt9cUsXjmm4sI+1OdwFgz5dA1R8+wAPe4tsz4LsCcDmim5ttTuIp83NyAr45StTynbr3IZd59k283MOlHGn9Qccws3rbz0cN73JrxmCxEfDU2PCMJKYXMSAnKVB3DfF/8NFvY0tES2SMQmfvTIHnX6mQPFjrJj6I7QF3qBSsbyJhH6EmbmvHG3r3faCpE/E1imlxEfn3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(261026121527099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(5023799004)(4143699003)(56012099006)(261022113327099003)(261009223027099003)(261022105027099003)(10067099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJQTkM0bzdjcS9KVVE0cjNwYVRWSnpxSGUwVnlQNDM4UldDTWJ4S1NkTnpC?=
 =?utf-8?B?cDgvRTFnZTljcFRQblBqdEl3K1M4ZW40VEpaOUFXLytGRXpZV0JYUko4cXdO?=
 =?utf-8?B?NU1zNFUwRHQ0a3J5UytqZUhIU21oWk1CK1VvNU1wN1puU0orWEw4Q0pjRExE?=
 =?utf-8?B?dzlSbHFJUDh4OUx4MWNWbGM2eXdXWDdPcmE3L1FCV2owMTFyWDNwSklkd0tj?=
 =?utf-8?B?M2thNzRkajJ2MmhnSE1BQmRVdnlzQTg4QU1WUWwwcTlzb3hQN25KT2pEVkZq?=
 =?utf-8?B?d2ZOeXRPeU1tZEYxWHJ5VGJuR1hRZDBGM3lMS1B0S0phOThTZEhTQ0lKSk9Y?=
 =?utf-8?B?c0s3MmFHWjJpZkNZQnlrUEFkN3Y2aVI3bHJTVnRHd3FLWTJSNEU4UEdDNnU5?=
 =?utf-8?B?UlZxcjJjY0l1NE1VbDBneHYveUNod3JudUsrYjBjZmZYV2V1S0I0cVJrR2Nm?=
 =?utf-8?B?T1FlNFJ4SEI5elhIMExtdExrS2sySXppeUZjZklUbllDZkIvS3Z1aVVWcTNo?=
 =?utf-8?B?Y1paR0dhWDM1UTlZSmFSbHE1Yk5QNnFYZXA4MEtiaGNPaERWS2tFQUl5NEg3?=
 =?utf-8?B?TklNR1NndDd2ajNlckhDdmw0eDljTWxOWHkwaG9LWDBZRzI0cnFnR1BQSG1V?=
 =?utf-8?B?akpoRlR2eTFhR2NBZ3NEaThodVVqc0paRm81aFo3ZTROdHJJRlF0NldzOGI5?=
 =?utf-8?B?ckxjb29pL0ZWSUZLMWtQTEkydk9acHM4Qk1wVmVsYUZSS1lsZE9wb1BBZ1lZ?=
 =?utf-8?B?Mk80T0VMK1Jmb3RSZktKZlgxcHRTKzhweWZpdFp1K2sxSTJZWFd3ZnI5QVFt?=
 =?utf-8?B?N0hhNitWMmZQTGJpOGUwN3ZITjk5ODhLUGFXblZSODJLZWgwZ2xsZlJtTktT?=
 =?utf-8?B?RDR0WjAwaytVSVVKWnp2TjJScUNZcU50Q3o0ZERrN1YyVTVUb1Qwb2lEeHZn?=
 =?utf-8?B?aHZ1a05yTTFtaExHUzhFaFk4b1kyMXpnRTl5YXRkZUFHdjVxZWZWd0M4UFpp?=
 =?utf-8?B?YUE0NHBIQVl4d3RidVBBUkh5ZXpSeWVZdDV4OFlPRGlCR29LUHF4YXNRZFJ5?=
 =?utf-8?B?NGE4SW9mNU4xTm1CaFdQZW9XSHZmNFlWN01vcy82RzRPeG1nYVY5dXN6Mm1L?=
 =?utf-8?B?MkY4azhNbk1FRFpHbWVVaGVVTG9Kd2NLcjFuc0FpSXFxMU52RGttamR6MUtW?=
 =?utf-8?B?T2d6eVp3NG14Y29lbUN1MGIzdTNldnh2bVVTajZtMlV1bHA0TGgrRmhBbUo2?=
 =?utf-8?B?MTN2dFprQ21WV3B4d01Ga09jWm80QU9VVWpTYVdabmhBWVBBWXdYcUlCOUdx?=
 =?utf-8?B?N0J6REx2UHR6Yi94WHk3ZnNuc1NiTkxuek5JbllsRTVYOHI5eDJNeWY3S3dV?=
 =?utf-8?B?OFV4SnNkK0VhdFVuSWF4WEt6TlMvckxROEs3cTU2TFFHVTUyVXhYN1Z4bDAr?=
 =?utf-8?B?d1FwNExaZEtGaU5rY0xuaHlCYkloT1g2MVJDYnhQSlh0VXk2SWxpeWo1UHcw?=
 =?utf-8?B?SUlpNmNFTnJLcDMrZU5nRmYvZlc0UzB1b0tXT2ZqeTUvU1RnNnZha3I4ZUo4?=
 =?utf-8?B?OFV0U1A1K1h1d0pYdDgwT0hxWDFPakFBb1Q5dUxNbVcvL0ttZ3ZuRHVaZkJD?=
 =?utf-8?B?QnBIdGYzdThrQmlmcXRBVnJIamY0NzlVaFZYYnk5TXJ5U1JYcFp5RkRIc0Jt?=
 =?utf-8?B?cnhjbXlSSHVGcnAxZk4xV0c4UGhEQlZZbnlQTjJMV2Z0aW55dlRkWUpwYzRq?=
 =?utf-8?B?Zk5Nb3lzTmFFZGw1bUpPZkIrbTdvc0EvNUZBTnp2WjJDUUZ5R2wxOFl0SUxC?=
 =?utf-8?B?TTZHSkIzc2NRTjVvVFoxaVc5UUlobEdnNGZWaklvMmFIdHpoYitBYWtGNGpG?=
 =?utf-8?B?K2taZUZsTkcwakI1bldpV2pnNHNwZmdsVTZFbjBXRmg3VUx5OG83bHkyWUw5?=
 =?utf-8?B?dE9QNFh4T1VBSHM2YUNDa3NabHZuMG9qWlRuU0hvQ3FaNzRBWmhmVXUxU28w?=
 =?utf-8?B?Y1Q4ZklFOWRsc3RFeTZZN0VuZ2xrd1pWVVlxdVFGaCtqS21Dekd4c3d5V3Nw?=
 =?utf-8?B?N2FJQkliVEpUNlg4Sllqa3VLR1gwbXBRNVVKYjBrRnFoQVBtcE13TkJOazNi?=
 =?utf-8?B?dGNkMUFodjkxS3dqdTdJR2xBN2wzTkNIZzVYNllXdHhjVGM2bHI1eDlMcGdl?=
 =?utf-8?B?VHp3b1dOQ1hpdGFBVS8vSHFIcTNxanBvTVBIRWFHdkpKS21aWnBCek5oVjlB?=
 =?utf-8?B?YjNnc1o2eDAvQVRIN1g5NkdxQ3F4SGh6dG9RQlZ0bzlYUkRaeVlpL05qM2V0?=
 =?utf-8?B?N0Npckc4U2lOQmErbWFaOW40UzUrQnNZOEFiVnZlT3QxdTZRb3BOdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b012bf65-4bca-4e96-2bfd-08df36cabd2d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:14:09.6107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gxax5yHCDJcXT8OOZmqAVB0PMZFKICoRsQTtCoXFuxKUobFi5rjchAwXtvFK5oXnWoKrVy6KxR4RjZTTQF4XQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=tdave@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 10:41 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tushar Dave <tdave@nvidia.com>
>> Sent: 16 September 2026 19:56
>> To: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
>> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
>> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: [PATCH 2/5] pci: add validation for fixed BAR configuration
>>
>> Validate the fixed BAR configuration specified through the
>> fixed-bar-N properties on PCI endpoint devices.
>>
>> Configuring any fixed-bar-N property on an endpoint device requires
>> every memory BAR on that device to have a fixed address. Validate
>> that each assigned address:
>>
>> - is aligned to its BAR size;
>> - is within the appropriate PCIe MMIO aperture; and
>> - does not overlap any other fixed BAR.
>>
>> Under a PCIe topology with a root port, fixed BAR placement is
>> all-or-nothing within that root port's subtree. If any one endpoint
>> device below the root port has a fixed BAR, every other endpoint
>> device below that same root port with a memory BAR must have all of
>> its memory BARs fixed too.
>>
>> Endpoint devices with no root port in their ancestry, such as those
>> attached directly to the host bridge, are not required to match
>> their sibling devices. One such device may use fixed-bar-N for all
>> of its memory BARs while another sibling device on the same host
>> bridge uses none at all. Per-device completeness still applies
>> regardless of ancestry. Once any fixed-bar-N property is set on a
>> device, every memory BAR on that device must be fixed.
>>
>> Abort QEMU if any validation fails.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/pci/meson.build              |   1 +
>>  hw/pci/pci-fixed-bar-validate.c | 326
>> ++++++++++++++++++++++++++++++++
>>  hw/pci/pci-fixed-bar-validate.h |  21 ++
>>  3 files changed, 348 insertions(+)
>>  create mode 100644 hw/pci/pci-fixed-bar-validate.c
>>  create mode 100644 hw/pci/pci-fixed-bar-validate.h
>>
>> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
>> index 984c7327e5..150085c997 100644
>> --- a/hw/pci/meson.build
>> +++ b/hw/pci/meson.build
>> @@ -19,6 +19,7 @@ endif
>>  pci_ss.add(files('pcie.c', 'pcie_aer.c'))
>>  pci_ss.add(files('pcie_doe.c'))
>>  system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c',
>> 'pcie_host.c'))
>> +system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-
>> validate.c'))
>>  system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>>
>>  stub_ss.add(files('pci-stub.c'))
>> diff --git a/hw/pci/pci-fixed-bar-validate.c b/hw/pci/pci-fixed-bar-validate.c
>> new file mode 100644
>> index 0000000000..0b5baad8a0
>> --- /dev/null
>> +++ b/hw/pci/pci-fixed-bar-validate.c
>> @@ -0,0 +1,326 @@
>> +/*
>> + * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved
>> + * BAR address validation for fixed-BAR placement.
>> + *
>> + * Written by Tushar Dave
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/pci/pci_bridge.h"
>> +#include "hw/pci/pci_host.h"
>> +#include "hw/pci/pcie_port.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/range.h"
>> +#include "qemu/units.h"
>> +#include "pci-internal.h"
>> +#include "pci-fixed-bar-validate.h"
>> +
>> +/*
>> + * Claimed BAR ranges — detect inter-device and inter-hierarchy overlaps
>> + * across all fixed BARs system-wide.
>> + */
>> +
>> +typedef struct {
>> +    uint64_t    start;
>> +    uint64_t    end;
>> +    const char *owner;  /* device name, for error messages */
>> +    int         bar;
>> +} FixedClaim;
>> +
>> +static GArray *fixed_claims;
> 
> Can this live in the FixedBarsInfo instead? IIUC, the info context is
> already passed through the walk, and the claims only need to exist
> for that validation pass?

Sure.

> 
>> +
>> +static void fixed_claims_init(void)
>> +{
>> +    if (fixed_claims) {
>> +        g_array_free(fixed_claims, true);
>> +    }
>> +    fixed_claims = g_array_new(false, true, sizeof(FixedClaim));
>> +}
>> +
>> +static void fixed_claims_free(void)
>> +{
>> +    g_array_free(fixed_claims, true);
>> +    fixed_claims = NULL;
>> +}
>> +
>> +static bool fixed_claims_overlap(uint64_t start, uint64_t end,
>> +                                 const char **owner_out, int *bar_out,
>> +                                 uint64_t *start_out, uint64_t *end_out)
>> +{
>> +    FixedClaim *c;
>> +    guint i;
>> +
>> +    for (i = 0; i < fixed_claims->len; i++) {
>> +        c = &g_array_index(fixed_claims, FixedClaim, i);
>> +        if (ranges_overlap(start, end - start + 1,
>> +                           c->start, c->end - c->start + 1)) {
>> +            *owner_out = c->owner;
>> +            *bar_out   = c->bar;
>> +            *start_out = c->start;
>> +            *end_out   = c->end;
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +static void fixed_claims_add(uint64_t start, uint64_t end,
>> +                             const char *owner, int bar)
>> +{
>> +    FixedClaim cl;
>> +
>> +    cl.start = start;
>> +    cl.end   = end;
>> +    cl.owner = owner;
>> +    cl.bar   = bar;
>> +    g_array_append_val(fixed_claims, cl);
>> +}
>> +
>> +static bool validate_bars(PCIDevice *pdev, FixedBarsInfo *info,
>> +                          bool is_fixed_subtree)
>> +{
>> +    const char  *devname = DEVICE(pdev)->id ? DEVICE(pdev)->id : pdev-
>>> name;
>> +    const char  *overlap_owner;
>> +    const char  *wname;
>> +    bool         has_fixed_bars = false;
>> +    bool         is_64bit;
>> +    uint64_t     addr, end, wbase, wlim, overlap_start, overlap_end;
>> +    PCIIORegion *r;
>> +    int          overlap_bar;
>> +    int          i;
>> +
>> +    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +        if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
>> +            has_fixed_bars = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (is_fixed_subtree && !has_fixed_bars) {
>> +        error_report("fixed-bar: %s [%02x:%02x.%x] under fixed-bar root "
>> +                     "port has memory BARs but no fixed-bar-N= specified",
>> +                     devname, pci_dev_bus_num(pdev),
>> +                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +        exit(1);
>> +    }
>> +
>> +    if (!has_fixed_bars) {
>> +        return false;
>> +    }
>> +
>> +    /* Completeness: every memory BAR must have an address. */
>> +    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +        r = &pdev->io_regions[i];
>> +        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
>> +            continue;
>> +        }
>> +        if (pdev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
>> +            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
>> +                         "missing a fixed-bar-N= value",
>> +                         devname, pci_dev_bus_num(pdev),
>> +                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
>> +            exit(1);
>> +        }
>> +    }
>> +
>> +    /* Per-BAR checks: alignment, MMIO window, overlap. */
>> +    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +        r = &pdev->io_regions[i];
>> +        if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
>> +            continue;
>> +        }
>> +
>> +        is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
>> +        addr     = (uint64_t)pdev->fixed_bar_addr[i];
>> +
>> +        if (r->size - 1 > UINT64_MAX - addr) {
>> +            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
>> +                         "addr=0x%"PRIx64" + size=0x%"PRIx64" overflows",
>> +                         devname, pci_dev_bus_num(pdev),
>> +                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
>> +                         i, addr, r->size);
>> +            exit(1);
>> +        }
>> +        end = addr + r->size - 1;
>> +
>> +        if (is_64bit && !(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH) &&
>> +            !pci_bus_is_root(pci_get_bus(pdev)) && addr >= 4 * GiB) {
>> +            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d is a "
>> +                         "non-prefetchable 64-bit BAR behind a PCI bridge "
>> +                         "and cannot be placed above 4GB",
>> +                         devname, pci_dev_bus_num(pdev),
>> +                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), i);
>> +            exit(1);
>> +        }
>> +
>> +        /*
>> +         * wbase/wlim are both inclusive bounds (mmio*_limit = base+size-1,
>> +         * set by the caller alongside mmio*_base), matching end's own
>> +         * inclusive computation above.
>> +         */
>> +        if (is_64bit) {
>> +            wbase = info->mmio64_base;
>> +            wlim  = info->mmio64_limit;
>> +            wname = "64-bit MMIO";
>> +        } else {
>> +            wbase = info->mmio32_base;
>> +            wlim  = info->mmio32_limit;
>> +            wname = "32-bit MMIO";
>> +        }
>> +
>> +        if (addr & (r->size - 1)) {
>> +            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
>> +                         "addr=0x%"PRIx64" not aligned to size=0x%"PRIx64,
>> +                         devname, pci_dev_bus_num(pdev),
>> +                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
>> +                         i, addr, r->size);
>> +            exit(1);
>> +        }
>> +
>> +        if (addr < wbase || end > wlim) {
> 
> This will reject a 64-bit BAR whose requested address falls within
> the low MMIO aperture. That is a valid placement, right?
> 
> Is restricting 64-bit BARs to the high aperture intentional?

We shouldn't have to. I will amend this in V2.
> 
>> +            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
>> +                         "[0x%"PRIx64"..0x%"PRIx64"] outside %s window "
>> +                         "[0x%"PRIx64"..0x%"PRIx64"]",
>> +                         devname, pci_dev_bus_num(pdev),
>> +                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
>> +                         i, addr, end, wname, wbase, wlim);
>> +            exit(1);
>> +        }
>> +
>> +        if (fixed_claims_overlap(addr, end, &overlap_owner, &overlap_bar,
>> +                                 &overlap_start, &overlap_end)) {
>> +            error_report("fixed-bar: %s [%02x:%02x.%x] BAR%d "
>> +                         "[0x%"PRIx64"..0x%"PRIx64"] overlaps %s BAR%d "
>> +                         "[0x%"PRIx64"..0x%"PRIx64"]",
>> +                         devname, pci_dev_bus_num(pdev),
>> +                         PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
>> +                         i, addr, end, overlap_owner, overlap_bar,
>> +                         overlap_start, overlap_end);
>> +            exit(1);
> 
> May be better if we could pass an Error **errp through the helpers instead
> of calling exit(1) here and let the machine code handle the error?

Yes.

Thanks.
-Tushar

> 
> Thanks,
> Shameer


