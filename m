Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C81CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwL4-0007Mc-C0; Wed, 17 Jun 2026 15:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dma@nebius.com>) id 1wZvlY-000794-9d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:17:36 -0400
Received: from mail-francesouthazon11021140.outbound.protection.outlook.com
 ([40.107.130.140] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dma@nebius.com>) id 1wZvlW-0007DV-Gt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bm4ecqO3yj4sftCHuEwGWIOXP8Su6FYDbHMxs2DNxmK5GaACR1Z/Zdhgz8scdcAiZ/bgkWOpCE/LFnZjFc0Jow2J/qhr40vD9yJ/tCJ4acniM3iCNMuHyeSHCEjdiLMOXcWHFeS7VRMNMLoeJ12VvCNbYFiC5lnJtqFsm0NIXBHxvxi23PzOOLHhu15pyxI4itqNEdq0ommz8dYy9qoO0Xax3+4pM8d4xXszssh8DIRObyY9At7K5vwrk2gtExdSAMVfhjSmyiB8D09KfnV7+dHXc5RCQFllMkElvu34r1KmgTTzcTLRA+NRGbRnCO236vjKClWqVxGpWTvsDMPSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLfLTymAf2yqPsVrhguys2a9r5DP+1u0H6VhvI7/umA=;
 b=vKNSse7f+ANoTOaESeUzjyrAKbSEdhb8ZuRjyWh35w0CSMEzKL6qgx5LXYxxB7nv/jhAaJCXNBOsayQqLE57FdwNqblNoFSa92Ah3O3lLuKkVeb7rSD0iCnZLqhun9SXFcxi30O5oN9MUPqjLUomFtWLYu7WDixAgElnhqNppL4B6gCvgwtbLpZHcpRatz+mzJ0IFv7kv18B+QuM8IHNj3tkQuZCnzL8iWRNPlTXDN0Ihuw4yVLO47LVfAhNvU/b8IcmehafhtlAZSl4XOuIwD819gQz22FyuhmQSesa5XLWUmhJ0LO+GL5hEsMUSFmtD/+wuHqfTvt2gwIwDG3ErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLfLTymAf2yqPsVrhguys2a9r5DP+1u0H6VhvI7/umA=;
 b=UDF4PpAJOsrjKz9A0UYn0eQ71ZFhOGc+ldiJl/VFEvlW0t01hhApMaEHqwgk5PUSL3Gc+DJ4mGRD6ySLldFntu76M5Dpbyc/vdzvMg2bT7muNP6IhOxKmiomvDQrY7ZRS3VNHuJRtoJAFyhQL+pHH86QYbKF7CJdVmIjvg7I1mmj9KGMtqu2TUV5WRcZu9gLQoXll4BKj6G1/QB9vxFcudVZvV96sb3wvng6IS0fn+ZZ5eMj+aBDcxpAYEit6uf46ET9CqT6WgZG+AEKBYwUgdt+NsV90ReNjrT+1n211NdfIYws8wRvReaEUh/0DTAUiw5De+fhxlGoJ0JoKYfYEA==
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4fb::18)
 by GV1P190MB1874.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 19:12:25 +0000
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0]) by PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 19:12:25 +0000
From: Dmitry Malkin <dma@nebius.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Dmitry Malkin <dma@nebius.com>, NB-Core Team <NB-CoreTeam@nebius.com>
Subject: arm-smmuv3/iommufd nested: should S1/S2 nesting require singleton
 host IOMMU groups?
Thread-Topic: arm-smmuv3/iommufd nested: should S1/S2 nesting require
 singleton host IOMMU groups?
Thread-Index: AQHc/oyVoSij5AB+d0q25ixCOUb6sg==
Date: Wed, 17 Jun 2026 19:12:24 +0000
Message-ID: <PA1P190MB25570FC9C98571680CFB55ADDBE42@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1P190MB2557:EE_|GV1P190MB1874:EE_
x-ms-office365-filtering-correlation-id: 2c986a17-daa0-4d4a-6261-08decca45d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|38070700021|18002099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: T8uXLOuF7IRitIL2VZUt8KQoyTN/ovT9P/dF4MEuDbTQJKuArYSQjpuUXVM0ks05KViGAVfys6jz9plmYHOy6AVuFJlfm224qFxSMTwliIO+4VUR3ZAUAmGUyrF0PvQuBbwKniukzDEaGZUMS/4kPRRAV5c6xzHINTtsm+BGWCCI6IQFkXrRbx+tuli9mS4mj/1IFxXxPyMsDta2bTpSo+Gwh1chnggJqGFxIn8Dhgb/7S944LQ0mmcG5eYVdrJhBAfF91ZKLVy6ynnyjTx3rdugnUmG9GsK4C5I8GPFKE7OlC2bZ0F0A0M7+PF8Y07gRfog+xmEY2fKYULMHUmaGdFNaEv8uLj5JorcZDgVfLlBZD++svyIySHKEvanACGlAXZv6+fNXQA0I/UI7pFMm89S2skjizmK4K6lUUX86hIaSUxDxcxkze7uGCfxhDOC+goMgBBtG6MdUhYmXRYSPQD+9b5ANiT9jUU641XXWrAgwKzn+uk3wx+zhsdAZm/54oRWBCSXRqB/9nho1sf2mWAbfUkxAu7BGNqkl91RkUxGv2QUjOVt9IPl0MPYyT2VOEGMJpsybpMj/XHhupFcvij/kugm9zAdfkbmZmFastyRlvFNckVDDjuFJ1GguzyUET44ulgj4klqCq6Cy72gGIO3WgKrNn7qreRRv/Ojk0PPV8k9I9JT/ffQeW7vPBwzM/8p4WwYak2rr3eJUk87dylVwUtseznqXlkF0e959P7NA6zxoSDZ2uF3O3L408Yt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1P190MB2557.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(38070700021)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FamQ1g6u10pRpZVxhFq8CoxKzHJKtKH2sAStcGT6ztouUcba1Ta1mlgFtn?=
 =?iso-8859-1?Q?uOMGdEjjUCu8W2pOQZgKNAp4gOr6qBNKjkoBSc8atLAkDJfEWy3ca6sAjy?=
 =?iso-8859-1?Q?LhO2119NJYyGf6+jy334KG3sGBi6rxBM9tcODD4E6znOmXH0WnBDCEaRqd?=
 =?iso-8859-1?Q?b7RNe16kIa7o0bk6+FnJzr8j48SM00NiQMCIAo3C4NW5UpdxmL8q0KnR2/?=
 =?iso-8859-1?Q?uloD2AKbSpSRaxB9QyJVTy76CYY4CWhUw7cIZTIMcWthRmf58dcKrjzvqH?=
 =?iso-8859-1?Q?xtp6+2rEGLFgQK39YYk3kJRzjuc6UpQqQN18+2U9n9w4KzLkcPNNr4pXtG?=
 =?iso-8859-1?Q?766tMV2A6A9KXdScQ9h1oUuSvP5Hc87KBPpM2Dp+vmDGqjZ47UB7BPYyvw?=
 =?iso-8859-1?Q?z3ICQhUMy/kQ2XI2PSXLYpfAOZnpRCLNoehS4Q6AyVo68E7ZSdy1+7z324?=
 =?iso-8859-1?Q?MnN+J6fI+ZZ4xGZtngAxZXkObFKxWFvAPsB/htr00KLCIY52jXD3APkaaq?=
 =?iso-8859-1?Q?DWi0gbbnrgv1ZFzHSICksrdjcfj3WNlQq5BUZamxgMdLiDN1REWRtHcJNx?=
 =?iso-8859-1?Q?UtxUr3iyeJv99Ls2en19fW1Jek4SNFMfIcklcXA0Qwkq+7/GCDsZmuPDMK?=
 =?iso-8859-1?Q?Dnv52y0Ln2IC3aFurRE4/U3Ig5JkdNTj2GaP9D9Uz2F32WDwsFuPXrR2uE?=
 =?iso-8859-1?Q?rh14adzowhhWvEjMPCHmYmJ4cdo3yOGA3ZgNdrhhjxRBaHgrJ1K3KFd3Zz?=
 =?iso-8859-1?Q?eOBKIZvyFFCTT2HVzMGKBMO8P7RO37bFHEhPO3fCObIqtqQD9qdDmY0PKd?=
 =?iso-8859-1?Q?0rabdnS2nmjdm6lWMne8aynhS4ox7DPixYNRqYmen44FR3eyttU+MHRrSI?=
 =?iso-8859-1?Q?y6V4w3Su4Y36hCBHMDxZ3DKTDikj62rRZqiPmQlXvkaK4HR9CxFjeSFP1b?=
 =?iso-8859-1?Q?T/zTOJlMWNXFuhqiAZdEdWgL0QLvCRxD9VSmKD+2iEpkk3AzYuCyq/QDXL?=
 =?iso-8859-1?Q?7XPkfgWEcFntQW6DrNZtij1MTaTiLmJrN/qg1Lefti02X+JEuoMEvwZtiP?=
 =?iso-8859-1?Q?tlSP1YfCbclrcbN8XzQrqvcmCZriqs4CxB8WHyxmKxXsg4+RQE7ZRJ+WUq?=
 =?iso-8859-1?Q?PiMX4qJsyXxzrq5afHdlyf8uQm6ngIer+v8ikfJeXYN/znaVBq/Clevna+?=
 =?iso-8859-1?Q?9Lg2wBLDXVuKGofHRqJGBN+qXQwPglxtdBLoXb3yJ3Sil6rejIdf/gTNZw?=
 =?iso-8859-1?Q?c0X5TS2e6gP+BjWl550qwO8ldeOFE5raTqwdivzTbEXisV/WGGUdTQAtPl?=
 =?iso-8859-1?Q?92I/ZdQWdHOA5lC7oSVwoYa2bi2XJNvPEvemdyXAPROvZ9itfNZhAtlQP1?=
 =?iso-8859-1?Q?Fi4Gh9/V4RDrN5kOlFGJ+xvMl8C9LSUKi7OjoMce7T7u7tPF9fIkgwgGTS?=
 =?iso-8859-1?Q?C1JTl0RAC1u0uxqkiCmxzv+ZvKmrXtenrPnRyM1KJjzBMhrWT+iSCYij/p?=
 =?iso-8859-1?Q?edBiq2sGm8ruzuZDmwPqmtgGsPxu/5teiTwI4DSU6HZ9uXRviDyhmuhAwg?=
 =?iso-8859-1?Q?Il7QzIQiaIj6bwKorEvlOvc6iBLDRDOsonzOulZxAv2+K+1/uxczzr1iAt?=
 =?iso-8859-1?Q?jFr4OJaZazTuwogYYgYtN/YZHSIQELaCmUUBxfcTatdXrDdJh+0s1o8ifC?=
 =?iso-8859-1?Q?2wWmMvthlIUEozLHEbI0o+Mr4sfPf4wmOUZ9XY/jFjChQk+0rHJKHY+qfJ?=
 =?iso-8859-1?Q?Doz8kZv6lgmCjQogN7JHM6A5+GtPd4TMm/SuRjh1/wzEL3kAj58qeVEnk6?=
 =?iso-8859-1?Q?+xWw1oqKNBGhSA1D05lhZ6ACXY6tHjKINtUMMu9U8nIuouR7XYlI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c986a17-daa0-4d4a-6261-08decca45d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 19:12:24.9818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4crhCOpxuWD6O5feaBWDsAufdyOGwmKnyTBoHtaL3uNPnCGq3jnd1jFIJO5mLpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1874
Received-SPF: pass client-ip=40.107.130.140; envelope-from=dma@nebius.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 15:54:14 -0400
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

Hi,=0A=
=0A=
I am debugging an arm-smmuv3 + iommufd nested translation issue with VFIO=
=0A=
passthrough devices.=0A=
=0A=
Setup:=0A=
=0A=
- QEMU uses `-device arm-smmuv3,accel=3Don,ats=3Don,pasid=3Don,cmdqv=3Doff`=
=0A=
- Devices are passed through with `vfio-pci,...,iommufd=3Diommufd0`=0A=
- Guest programs translated SMMUv3 STEs/CDs, so QEMU allocates nested HWPTs=
=0A=
  from guest S1 state on top of the host S2 parent.=0A=
=0A=
The failure only happens when two assigned host devices are in the same hos=
t=0A=
IOMMU group (done via pci=3Dconfig_acs):=0A=
=0A=
  0009:03:00.0 -> same host IOMMU group as 0009:06:00.0=0A=
  0000:03:00.0 -> separate host IOMMU group=0A=
=0A=
QEMU creates vDEVICEs like:=0A=
=0A=
  0009:03:00.0 -> virt SID 0x400=0A=
  0009:06:00.0 -> virt SID 0x500=0A=
=0A=
Both share the same vIOMMU/S2 parent, but they may have different guest S1=
=0A=
state because the guest STE/CD is per virtual SID.=0A=
=0A=
The failing sequence is:=0A=
=0A=
  guest programs translated STE for SID 0x400=0A=
  QEMU allocates nested HWPT for that STE/CD=0A=
  QEMU attaches the nested HWPT to VFIO device 0009:03:00.0=0A=
  kernel returns ENOENT from VFIO_DEVICE_ATTACH_IOMMUFD_PT=0A=
=0A=
A shortened log:=0A=
=0A=
  smmuv3-accel: nested CD sid=3D0x400 host=3D0009:03:00.0 ...=0A=
  iommufd_backend_alloc_hwpt ... pt_id=3D<viommu> ... out_hwpt=3D17 (0)=0A=
  VFIO_DEVICE_ATTACH_IOMMUFD_PT failed for device 0009:03:00.0 to id=3D17: =
errno=3D2 (No such file or directory)=0A=
=0A=
If I change host ACS/grouping so that 0009:03:00.0 and 0009:06:00.0 are in=
=0A=
separate host IOMMU groups, the problem does not reproduce.=0A=
(i.e. by removing pci=3Dconfig_acs from kernel command line)=0A=
=0A=
My current understanding is:=0A=
=0A=
- VFIO/iommufd RID/no-PASID attach is host-IOMMU-group based.=0A=
- SMMUv3 nested S1 state is selected per guest SID/STE.=0A=
- A nested HWPT allocated from one guest STE/CD represents one S1 context o=
n=0A=
  top of the common S2 parent.=0A=
- If a host IOMMU group contains multiple devices/masters, replacing the gr=
oup=0A=
  domain with one nested HWPT cannot represent different S1 contexts for ea=
ch=0A=
  RID/SID.=0A=
- Linux 6.17 also requires a vDEVICE/vSID for translated nested attach via =
the=0A=
  SMMUv3 vmaster path, so group members without a matching vDEVICE can fail=
=0A=
  with ENOENT.=0A=
=0A=
Questions:=0A=
=0A=
1. Is arm-smmuv3 nested S1+S2 acceleration expected to work only when each=
=0A=
   passed-through RID is isolated in its own host IOMMU group?=0A=
=0A=
2. Should QEMU detect that the VFIO device's host IOMMU group contains mult=
iple=0A=
   devices, or devices not represented in the same vIOMMU, and reject/disab=
le=0A=
   nested S1 acceleration for that configuration?=0A=
=0A=
3. Is there any intended QEMU model where multiple host devices in the same=
=0A=
   host IOMMU group can have separate guest S1 STE/CD state while sharing o=
ne=0A=
   S2 parent?=0A=
=0A=
=0A=
Thanks,=0A=
Dmitry=0A=

