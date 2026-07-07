Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22A0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whE71-0004aA-Oq; Tue, 07 Jul 2026 18:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alwilliamson@nvidia.com>)
 id 1whE6s-00044M-R4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:17:50 -0400
Received: from mail-northcentralusazon11013071.outbound.protection.outlook.com
 ([40.107.201.71] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alwilliamson@nvidia.com>)
 id 1whE6q-0000Nc-9F
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:17:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtvKoo6NwG4YfU0bAMDHCfYzb1L3CoqCywvXPfi9anusYxtXFjCv8m36cDPDqTxUs7sKjuhi4b8Uh6EhO9TYzlWOlaiopJI0N/BzZsJVdmyKnFRjcysW7drqw8LM3nz/v+rqv1Gt3PcATuL5GBdCrM8RvEKP4VtMPfujb2ijfxzRkNh44sANp3xLyqJgQtS/2mKy2vLGcSInIoP7c40MzCdMqWLuBaVDclS3rBnW6eY2E2AlZMocriRDv8GsklLCNY4wJDjLWvDTye/PFUFOsHyMVVTH6pSBrcdM9MrhCD1evtYZDLxWcxI14fvs5brniE+wwEge+/RjOq3TdwCISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifllKCCmVSHOYjiGJOOt1GFJTXBGq3obsu7KiXT9gJs=;
 b=VO+jkebrCLsxq6Qw3Ee7MpUMF48KVfuDN5yLGVJO/BTLcvcDHRK93rz7MeQbnSV2OOqIOkXsWPY5UXyiLqfhyJtwcP5Bg5AiKntCKE6rKxEIH8IrydBHs8qdCjovbJVPUQZSZf6qS4DvEiDOmJvlSE1smmwcwFUYfndes2OUBboJmOYOirSVSgxRkP5TlOVvWQ5VJoGuVcQ8p0anrySxUPLDll8fggWNg/Lav71u+QNHmQNZS0q7bBZ7v/L9LHNK8fweTvJLonI6lkTtHLtZkbEY9m8CFU6AaA7GRyAFfw9PPVj/jYI1s9sYrdDjlBx0HaweFiudafQ49K7n9WzqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifllKCCmVSHOYjiGJOOt1GFJTXBGq3obsu7KiXT9gJs=;
 b=qQ8iEZ/PdAWw+bdxBT81lHkWKJEsqwQq53qhhzWu5kEh933cRwSF6cCqtaQX2Hc1dVxdRQtCQ4UVuiuInSLsMFPzGQjqleBHkNvCK1ZR0RGN8Inwjr2XNKArpvUvtYVudhQuT1X1MdRQr3BpeoFMOmb5lCG+yGRKbx30m9SLYnuOSbdaTpIJc4J3VgQeJFKQ/QmT0E6R6aX9cDSid047bAMSs6VFMck1y+tT98s7xnq5e+U73Ks36BR8Shvvt1rtD/w9oUpIEe8trosPjXGRneMFSVC5niin6EWYxqfTiDheQh8M1HElWQ1sqydsqh6jjkc36t8N1RZB8Fl4gYQUVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 22:12:37 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 22:12:37 +0000
Date: Tue, 7 Jul 2026 16:12:34 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <qemu-devel@nongnu.org>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [RFC 0/1] Forward AER errors to guest
Message-ID: <20260707161234.23ed28db@nvidia.com>
In-Reply-To: <ak1oWDUvX49OfFmB@nostramo>
References: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
 <3500e357-1a3e-4325-9259-28c2023860a1@app.fastmail.com>
 <ak1oWDUvX49OfFmB@nostramo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: d9be8c6e-7078-4ca8-5cbb-08dedc74da4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WiZnplQIElSq0x81ff1f3TFo+gLKTxsH6qliqIo9Gm7e7fGCPIJH23hc1/G2nhrezLJT8GHldt86B8UKYeJQVkmz2WxuToY59tgjR6Dz5K+56Qrf5vkAWxjqtknoC3/0r+R/KgpfPxFONclg+cBtiEDguNI0mAlsaKpmNqG08iRSVuxltLYEKXqD30z9yANNrxDMrH0NWTX5LyEW1iV2Zjc+88N5awz3CTXuTtAIB+XS8TOGKZdhyK8YwejMxoLNIaPCox75WRR7wWFDAuVKYdiK46GpYNIXYd1m8bR3goEBp7ArMXAXJgLg75RKtJgEGB+kAiCTw8ZOyTJ1xAzcwgxp9sCECMFIZ+M9Q6nda09m0XYSaggxNojkcLe0H7iPBYpt3+H0Jv6G1vB8XPgUYVYs6kv9PkEGzg5n3cKHkpIQZ1GlDlVpTnJftLp8d80++R7W0Wiw83fh5/rlkSJ0U6by/2du6L+7/zhJxDEY6iPB9uABTW0Ersgu2Bt3h0yWca+tY3jKQugfMbHpFjuQealRmtU/ACowB75qwOHpqvTHFEqRsWnfVEFGOLRy40WetC5uIaR0psabu1jbasJaeVLgRilgF03t9HrMmjopOaxScLH3PVNgwKq6jRKfS9Bb2NEofMYOo2Jgka0pVQbF7IcSAtTrCcR2BNOuPsjzXwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhhbmtlc0hDWXRuQzZEcERXZ2JjbUx6V05DQzVaTnl2bTRZSDVHaGNqODNJ?=
 =?utf-8?B?UkFTbHhLRnB4MUNnYVM5bnFiSWFqS2pTOXFPU0t5NkVDbzRRaDUxYkhXOWt6?=
 =?utf-8?B?NHZiaUVoSU1pUjZLUEl6ZlZlbWloOGp0Y2Rud3JYa2hNM2ZxK1ZsT0g4eW5I?=
 =?utf-8?B?OHJYd25Fa01lbldJbHdEUkFjdkdPR2lzVW5URjdGOFFGampDNFBEVHpCVTVB?=
 =?utf-8?B?WFh1aXNRN3lTYWlycHRsUDc2WDlZVk9JblBPQ3FrT1NNdnl4WEFScWlZWGpP?=
 =?utf-8?B?UC9jNEhLSVFwVDh5aUNtV01MSTEvQ3NtK2hkcnlYSTVQMUdvYTVudmRid1pm?=
 =?utf-8?B?VWtOZFl6REVHdjlDRkl1RmN5V0VuL05YbDc1RTA2M2ZITmRSc0QveDJQeEwr?=
 =?utf-8?B?VmlLNHc3c1RDWkNrcmF4OVc5UDBKL2tsN3ZZTW5ncHN2cEwzRVNQeHdTWGd5?=
 =?utf-8?B?WHc1ZE1tVkhRT3NyNEZpUzdnWCtkSStDbncyY3BSclVsTkZsaG92cjdHbWJ1?=
 =?utf-8?B?Nm44dUNtSWlKSXdHTU5DUUNZMThCL2J6eDlHMWEyODRCMUxuUkpsRHJmNGZZ?=
 =?utf-8?B?Zzl6czFNL3drYnd3Z0h1c2M2WklEcTFnQ0ovVnh5UlNSeVhPS2QxY1JRZ2gx?=
 =?utf-8?B?dUI0UTduNHo4OTJoUmMydkRKd1hia0h0WXFzRDJENVBoK0MwWlM3M0VoOUJu?=
 =?utf-8?B?N3AzMGxPZCtrb1A1Z1FEMzkvdk5QWmFCZHg0QitwU2tXV1MxanVFVWpqNFU2?=
 =?utf-8?B?ay96anNTMGpJV1NQWEhXUEt1cjErRHJDQUttT3NDdlBnSnQ1ODhDeHE2Wm9T?=
 =?utf-8?B?MHA1UGJjaHhDSFM0NDZ0c1R6ZVFUaC9jSEdVcGZoeVdNVHl5MFZRTmFWTjJh?=
 =?utf-8?B?bHNpcjQ1RGZZbnBRdFArZlE0YUUyaGpnTU9kZS9XTkNkRTc3RkloT0lGRmlD?=
 =?utf-8?B?MURWeVRWYWY5UUZ5UWx4N3BIZ2hUM2pONUZqT2N6MkRSTmtJQS9KaUVIY1Y0?=
 =?utf-8?B?NHFPOVpSV1RuU0Z0TlpWQ2QrZm8vSzFjcXpxOEFwbWxYNmVMZy90YzJHVmNU?=
 =?utf-8?B?Wmg4cGFLc1NSdis0TjJlQmNiQmN1NUp4dW0xVm43VU5TMkZUQ0F0TGRWeDAw?=
 =?utf-8?B?MUZMTlphV3M2YWZFeE1CMWxaUEVXeGhBR005VHhtRWhyY0VlK0tXSGVEQ0Z2?=
 =?utf-8?B?d1M3RDBkQU9reUlUZ3VhMlNtbWkwVmUrWjFVcGpTSkpKSU9TOFFRMDZhc1JP?=
 =?utf-8?B?RVFwTWVqVEozSW5SbjJOQjl6VVJ5eDFocGtCR2FSWlVwcGhNYjVNMXZPanJI?=
 =?utf-8?B?dVVLSjhSU2NncjZvSnlpMjd3RnFnaE5vQTdIY1grd0ZxdVg3UTJRaVNzMUFS?=
 =?utf-8?B?U29sZTBEeU1heU9IL2JORUsrWEZUK2FVaEMwa0lZMm8zRG1yekU5WFQxRXBW?=
 =?utf-8?B?YzBwYitxam80VEpUT05CaGJNWXVHWEEyNk5UL1ZqOHNQc2ZaZitOMFNsQjJB?=
 =?utf-8?B?WVpvaWdNVlVkdCtXNkh5MThMZWhieFBHQStvZjhGNzlIc0UvYkY5cy9GWVBO?=
 =?utf-8?B?eERnRTc2eElTQ2NtNVNxYUczOFI5OVVzSEsvTk1EV0lQb01TcHUraGNtN3RC?=
 =?utf-8?B?bFRUeHdMUDloTXJNdThXTEYvb0U1R2JXNmVmOFBZM0pOMmhEeG0rVFdROE5Z?=
 =?utf-8?B?ZVBLWnRDSUw5SUx6TzRWNE9jWk16TWhmT2NQblp2V3ZNeEoyRUx3YlVDMEZv?=
 =?utf-8?B?YlNhNjZLa2xwSk1TRmpaRythc2d2UUxZYjFpMVN5dE9FemR6V0VkT2tJRjV3?=
 =?utf-8?B?cUxGRDBKMlBoYWo5Slk1L2RMMVF2ZHZrSkpjNitoMks4WmZWVnlOQndYdVhV?=
 =?utf-8?B?Rm50RXJzSkNtVG8vK25jMnpYMDEvMjdzc0I2NENDVkVldmlIS1pVaDIzdXZQ?=
 =?utf-8?B?M0VCa3FuSEJjRGFBUGMwSXZaOWU0YWdpWnhRUlhiN1FMQzZzRVhuMStmN0lO?=
 =?utf-8?B?d2dYN2RVdWNGdEZXUHZjTHJMenc1a2NVWjJ3VXR2YmlKOHhkbURrK2JmL24x?=
 =?utf-8?B?akN0UWNwMXFZNTZRTWlKQzM2MWlnbms2eXRPRUtOVXcwOHlPaHdHVVhHL1Zk?=
 =?utf-8?B?R1JDTERlQVFCdkROWlkwZmtiWGkzR1pWbTQxaXpCQ2JyK1pwNXBGTURCWDNI?=
 =?utf-8?B?MTRDaVJZdzJHWmlrbVdYZlA2a1QzNGFRVTE5Y2E3VFpydUt0UXRhVHJaVFhv?=
 =?utf-8?B?bHJyQ24zYndXbVB0VGNXQWxBbjlweFBpd2RzNnBVRXY4T3lGOG1vNWptTUd5?=
 =?utf-8?B?K1JGenordzRhUU9JcHlBcXUxMnVsSitaMSs2VGxCWWExQWdyQmVvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9be8c6e-7078-4ca8-5cbb-08dedc74da4e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 22:12:37.1926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQSYs8zWHkCg5ntZwqHqfKZNvNzRdRpd2qdmVRGV4E5HnOaFZCryQJD7KeJrINBqGvqpERs3bUfVw3rFXv3CQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881
Received-SPF: permerror client-ip=40.107.201.71;
 envelope-from=alwilliamson@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, 7 Jul 2026 23:05:33 +0200
Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote:

> On Fri, Jul 03, 2026 at 07:59:46AM -0600, Alex Williamson wrote:
> >=20
> >=20
> > On Fri, Jul 3, 2026, at 5:13 AM, Satyanarayana K V P wrote: =20
> > > Today, vfio-pci unconditionally stops the VM when any error event is
> > > reported by device. This prevents guest-driven error handling and rec=
overy
> > > for platforms that support PCIe AER.
> > >
> > > This series adds an optional vfio-pci extension parameter,
> > > "x-forward-aer=3Don", to forward AER errors to the guest instead of
> > > forcing an immediate VM stop. If the endpoint supports AER, the error=
 is
> > > forwarded directly; otherwise, checks the upstream PCIe bridge and
> > > forwards the error there when supported.If neither device nor PCIe br=
idge
> > > supports AER, the VM is immediately stopped when the error is reporte=
d. =20
> >=20
> > The error eventfd is signaled for err_detected in the host, this is
> > the beginning of the host error handling and the point at which
> > drivers should stop accessing the device until the resume callback.
> >  Letting the VMM continue at this point does the opposite of that.
> > Thanks,
> >=20
> > Alex =20
>=20
> Hi,
>=20
> Today - the default error handler used by VFIO is not implementing the
> .resume() callback and just signals err_trigger and returns
> PCI_ERS_RESULT_CAN_RECOVER as part of .error_detected().
> Qemu registers a callback to be called upon err_trigger signal (using
> one of the poll/select syscall variants), the callback calls
> vm_stop(RUN_STATE_INTERNAL_ERROR) - this is a runstate that can't
> continue, the VM is effectively killed (qemu needs to trigger VM reset
> to recover).

Yes, this is the extent of the implementation currently.
=20
> The AER forward was proposed as a relatively simple opt-in mechanism
> to avoid hitting RUN_STATE_INTERNAL_ERROR and be able to handle
> errors for SR-IOV VFs using VFIO. For uncorrectable errors with
> SR-IOV, PF driver can be the entity that handles the device recovery.
> The VF driver needs to stop using the device until it is recovered by
> PF, and reinitialize any state that was lost as part of the recovery
> action. Forwarding AER would allow the VM to move forward without
> introducing any new uAPI.

Interesting, nothing in the proposal suggested this was explicitly for
SR-IOV VFs.
=20
> If we would want to build a generic error recovery mechanism, we would
> need to duplicate more of the err_handler_t callbacks as VFIO uAPI.
>=20
> If the recovery is handled by other entity running on the host (VFIO
> variant? Or for SR-IOV, the PF driver), we could also go into a
> different runstate (RUN_STATE_PAUSED? something that doesn't require
> full VM reset) and add a VFIO uAPI that can propagate the .resume()
> into userspace.

And a .slot_reset() to actually restore state if PF is reset (we
currently rely on that happening on .release()), and we'll also need to
teardown things like interrupts (also currently reliant on release).

> If we would want the SW running inside the VM to handle the
> recovery... it becomes more involved, and it requires a more
> substantial solution that wasn't meant to be addressed here.

Note that the current error eventfd is triggered on any uncorrected
error, fatal or non-fatal.  How does the VM know which it is?  There
are certainly hacks we can do to limp along a little further with the
current limited implementation, but nothing that seems to actually get
us closer to a general purpose, supportable feature.

> So - we're letting the VMM continue but we're also informing it that
> something went wrong with the device, so that the SW running inside
> the VM can do its own action.
> If it's a virtual function, the driver can potentially fully recover
> after the host does its thing.
> If it's a regular native function, it will probably need to go into
> PCI_ERS_RESULT_DISCONNECT, which, for most usecases is still a better
> scenario then having to reset the entire VM.

We've been discussing this internally as well.  The VM can perform its
own recovery, resetting and re-initializing devices from a VM
perspective, but it can't "handle" the host recovery process.  In fact,
I think at best it could pause and observe the host process, resuming
and injecting an error after host recovery completes.

> If we would want to absolutely make sure that the users are not able
> to issue any IO across error recovery, we can probably unmap (or
> zero-map) the BARs at VFIO driver level, similar to what's done
> during reset.

Yes, the shape I imagined would immediately block all access to the
device on .err_detected(), zap BARs, fail access, and signal the
existing error eventfd.  The VMM would need to handle the potential
sigbus it might see before noticing the eventfd, determine whether it
maps to the mmio space of a device and call a new device feature ioctl
to test whether the device is in an error state (hand waving how QEMU
gets from the trap handler to a point where the VM is paused and we can
poll an ioctl).  Flag bits on the GET of that feature ioctl might
indicate Fatal/Non-Fatal, InProgress, DeviceReset, and Failed.  Perhaps
even a sequence number and/or SET on the feature ioctl might implement
a W1C style acknowledgment - some mechanism by which the user can track
whether they've missed an event.  QEMU could autonomously perform a
surprise hot-unplug on Fatal or Failed, or otherwise pause the VM for
InProgress to clear and inject an appropriate error when it does.
APEI/GHES handling in the guest might be particularly useful to
indicate to the VM whether a device reset has already been performed.
In fact, the whole process doesn't seem too dissimilar to firmware
first error handling that runs underneath the host OS on bare metal.

If you have better ideas how to handle it properly, please share and
correct.  I don't however see much use in nudging out a slightly
improved use case with a narrowly focused, experimental flag that would
never get picked up by tools like libvirt.  Thanks,

Alex

