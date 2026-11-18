Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4B606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=LmoGW3oV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgKV-0008DJ-Hw; Wed, 18 Nov 2026 09:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <casasfernando@outlook.com>)
 id 1xTgJU-0008Ap-Hc; Wed, 18 Nov 2026 09:07:06 -0500
Received: from mail-francesouthazolkn190110001.outbound.protection.outlook.com
 ([2a01:111:f403:d207::1] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <casasfernando@outlook.com>)
 id 1xTgJS-0004hP-KH; Wed, 18 Nov 2026 09:07:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw9lzwVJPOkMPqdgUjwmy6MpjezEGz1kpTO7cZy2VpMrviauJsTRn9QppkajJCxwhuKqn7P0lJvNpZ86FnhjoZalSXdJeBLdspFtF4UEGfCzsiMTzm1KQoqMVuBXxWzV+/1hksKIRvMiS+Gsm3o6ULP6JnTyxZ8n2STQZlNIMcold6hz+keyRdkyZxdMPgdNvNOcQuvk//6huOmF6FcrKUucUWc4WwFnXY8s2wFftjC4oXHz/u7AIPK3wSf3OGdFIAHO5klBMLD6QKlA8vdYsAwIS8Z9mVyoVvQdZ4YVKFu1Fzc03ndXx4QR5H5G6YBOpS1rjkgyBnWwgT0sNkGCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q2E37H2LtppEp3iVbSpxJdm2q3fzwxecdsy9fdyaJ4=;
 b=dzUN74RF6O2c4bkzUsTxT3/oWQcmnwVDNRu6t/jjzp3TGqIp0YCb7ptTxyntIK2rSneRic17Rmhroa/q1i1AjGOnoqaO1P5cNT23B2ctRoOt/ELD4sYn7Iiw9WgQfucQUERgnuLLaJFhva6TrE+UbPzqVjm53Y4If1XjoQVWBNLzPsCa6CLFfEj98R3XcYIIWkm+J8n4zyf6uFe1SJwoix4/IEMRppUA1mCpi9ekWuw4hSk46zAszNEWGjibLz5z28FWzQIdq9KVQG5cPCxt+NL1OPvHRggy9RurDzHSwKn6QzXA7oqzuVsxIgg4GQgWAHRrlmAq2UE9rFWz7sIqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q2E37H2LtppEp3iVbSpxJdm2q3fzwxecdsy9fdyaJ4=;
 b=LmoGW3oV0YcwJ4DPb+SJQ8xDauEo/IZR6VSUnSNhCAuCA7a47Mw3aztF9MeYIDBzzUpqzQJNbTldcfO6O1rJat2zBriNedeI30rzYueywPrF/j/W4a8BSm+1lSqGIpOv3CjYTL47+KMGx2R6BLVJTsn4/sYeZNj+z9ir69rVbAkwnfwNJI37gS33MQ1Mw5UiBIdTRoHLOejWRZoKH/nrfpJkhcsYE3IkExNUWMxHcZfDQCyJN5yVeZp7WaMzx2FldmtrFxdulUHxzHjMf7bASiAc7XicngmjU98OJ+wGe2MmDoOOUayRQ+3jzGITrzRZiYryodSeEYGNMpN1sR3CNA==
Received: from DB5PR09MB8796.eurprd09.prod.outlook.com (2603:10a6:10:657::5)
 by AM7PR09MB4069.eurprd09.prod.outlook.com (2603:10a6:20b:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:06:56 +0000
Received: from DB5PR09MB8796.eurprd09.prod.outlook.com
 ([fe80::59b1:a954:ca80:a481]) by DB5PR09MB8796.eurprd09.prod.outlook.com
 ([fe80::59b1:a954:ca80:a481%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:06:56 +0000
Message-ID: <DB5PR09MB8796247F71F1A97E2E808EA7A47A2@DB5PR09MB8796.eurprd09.prod.outlook.com>
Date: Wed, 18 Nov 2026 15:06:54 +0100
User-Agent: Mozilla Thunderbird
To: axboe@kernel.dk, ncopa@alpinelinux.org, stefanha@redhat.com
Cc: f.ebner@proxmox.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, t.lamprecht@proxmox.com,
 =?UTF-8?Q?Casas_Sch=C3=B6ssow_Fernando?= <casasfernando@outlook.com>,
 jmaguire2013@gmail.com
References: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Content-Language: en-US, es-ES
From: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6sow?= <casasfernando@outlook.com>
In-Reply-To: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0208.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::8) To DB5PR09MB8796.eurprd09.prod.outlook.com
 (2603:10a6:10:657::5)
X-Microsoft-Original-Message-ID: <bd66d729-9224-4349-af6b-bab1b1e448cf@outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR09MB8796:EE_|AM7PR09MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbec1f3-e1a0-4c62-1bcb-08df457d343a
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicApcBHgIkF1u3SRiU/lhwt0c2Bhs4QkV9hUDt6vDvlGom77FS59f9SMwsSOqO/DEY2+i+B6NmrFqcGfrVLA/HIj7cjUae6ZfV2uALOpPeiJyM8tmr2fEm78jabbpbRxwjR5w76c8BZLdzewfJGnljxy2YNiKez3CurxHpW+4Vs/DH+AFvKupELHZFgzK6iJsBe9B3UnEr2CpNR9zpM5tmCP2ulTg9SOUXPo/jPDxkSdBbPgttzKDSoQs+pT7krt4fhiA4G/NUpEg2Drz+meOHr8xZC0ibpy4+b5aYFqyMLcPS1fFAqRumnr86uoO+lfxkNqNpYRId9dAS+oJDkvvtnZ0y7l/C1m5Py40vKGzSn4acD5QI8QEJE/8JizDUlGFBxVD/2f+HR7HV9KySBiAC5VITdfixmnPEolceyfUiix7wqoDS5PsjLdKWMFjMIqPVtGCTiECDaKk4uMjCcutkZ91PLgliRJ916UHw9OcvaIsNne+mzaaQba5IiHk/FpOVhEi6cD9SofZ4/vTs50YDs4IGTYC3LN4rhgcbslCDsCIoiP/KKHsu9GnmEa/fccvcBUqbsauPhK4PqOceyoc0MrkI8hhwjKBmP5sovriRWkyfHvmdnDAVXfc/axpXkcgJzt0hja2EFlJnrxTZFnkIUYEMKqPicIByw2nuu2alBlgyNQm6Yix3r6laE00zMNWif7QKmkZX/JuTYnrUTOvZWo4EDOi4pNj/ibGkigY9Flig==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24021099003|39105399006|4140399003|25010399006|19110799012|8060799015|5072599009|6090799003|23021999003|37011999003|15080799012|40105399003|41105399003|18071099003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFM2NkNGNm1Qc3U1Q2ozdytVOTBvZ05XRDJ2WXBFa2owSFFHVENNeHZDdVNa?=
 =?utf-8?B?SjV1MzFlY2ZqM2lLSmxjWmR6YjFuSHlGRjFzRHh5TmFBTWxoUUE2K20zbk1F?=
 =?utf-8?B?eVNUaG9BVGs0aWNEa3pzYm8zQnhSQkNiMUxPRk1Ma0M3SXluU1haVyt1OTlr?=
 =?utf-8?B?K0VyRWF0R3pGMnhDTzc1M043b0l4TWVoNWdSMWMzMkJUenVZNGRLelBkSG1a?=
 =?utf-8?B?bVNkdWI3T2x2czJIS0hpb1BnRTM1OXUybjY2TElobnA1RWlCR3h0K0dLZ3NJ?=
 =?utf-8?B?aDlvQ1A3UUVMbWwrZDkvWDliK0NUOWZPeTI2YmpSczBzMEFNcVBoYm45OXhy?=
 =?utf-8?B?Q3JGYm5BR0pOd3NGUXIzdDVlZEc4WXVBa3VUcEJUV1dCUFo1L3VHdzNXVEJw?=
 =?utf-8?B?VTN5d2c3VTRBVDE0M3BZMFVjdStZalB4L2tmSjhiQ2RsR0w5T1RqVzF5MFdj?=
 =?utf-8?B?Ymd5UHIxL2hnRDBRd1YrSkhnWXY3Z29OaVZKOS82SVUwZ0NwWG9QbVpKOWNS?=
 =?utf-8?B?YnE3Y2s1RVBkelBxQ293cUdydzJ2TEw5TWgwUStwekU0dUovb2ZpRzRzdG4w?=
 =?utf-8?B?bmEyZXRldXBFOEJLdzRoRUFLU3B3UzExUWtncis2RUVIN3didnNHS0FZYW9U?=
 =?utf-8?B?Q2RYMGpZL0RNVjV1NnlIYTJxcDI2ZnlMaExRMTNEVytoSU9IS1BpQ3JpdUpQ?=
 =?utf-8?B?ZXFWQTZ0RU56YVpDK3hXMFpHMVYwenVHWVVyY1lrdlEzKytjY25jSStqcTR3?=
 =?utf-8?B?YjN4KzI5aEg5Zmx1cFJ6QUZSbUdGTlVGNDRPRTgyUzQ1OHVKM2xkVEN5SGpR?=
 =?utf-8?B?VFdFYUNBc25GWDBqZk8wZEVQWGs1Y3BQMkZPeTdVaFQxL2pPbnl6QnQyWWlP?=
 =?utf-8?B?djQwNVQyZXI2Yk80ZFI2eCtORFEzRzcrOTRMRjU2c3ZlWnA4UXRWMUxRZlFU?=
 =?utf-8?B?RWl4QWdNdlRIdTgzNlN3TlY4ZE44WHg0U2I5Wmd6d0sxOXF2K0ltWEh0UHRa?=
 =?utf-8?B?QzNBeStZOXRWRWFtTGNBQjZJb0NzZkZIQnRrR3VGdXNRbTJNZk9sTVFGUGh3?=
 =?utf-8?B?bWhabzVaa2JOSTA3RTJvcHpFc3dPTnh0T1c5NnZHTTNLUm5pR3hBdFlNZTV6?=
 =?utf-8?B?anNrNEhHSkN1SlV6TjloVkpFRk9IUXhyaTdRR3B1OEo2VjhIckdOdVBVWkVH?=
 =?utf-8?B?eWtTL240Y2VQYTJ6Q0lBZUlXcXFaYmFraVhxMTRrTWpYVCt4QzV5RVdKUmJm?=
 =?utf-8?B?TnVRVC93bVhrV3h6aDBMQWxVVjVobHVjODVjd1ZjR1pqSC9RTXU2cGozbEdD?=
 =?utf-8?B?VU1vQnhTRXR0ZWtkOEJmSU4wUHJQTDQrOXNUbHR6Y3NNakdocEtMUko5NXlC?=
 =?utf-8?B?Z0lRVmN5VVVKWnlMaHQxZlJxNWR0Y293Z2x4eG9IQnhiY05leXllVnJrUlZz?=
 =?utf-8?B?SXFSMHVvbDFUUnhWMEQrRGwwQkxiaHQ0NUQ1UG93PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5HQnhReWY4TnU3K1pldnd4M1pzcitramlKQkt6ZmNuTmtwQWFwanFoUG8z?=
 =?utf-8?B?MFdDZjgzOGpuNmx5eGZNK3NXNm01dzVPMlRtMDRDa2VlZjYweTB4eVlUNmVq?=
 =?utf-8?B?a0FGWXdacnZ5TDNrUm8rczZrVDRsZERaN0s4d0tUN3Y5QWw0S3kvM2J3b0VX?=
 =?utf-8?B?eGpYakZOSFF1cGdHSFVtN2hwaEFGbUF0aFEwNzYramZPMWpkVzUzaGxrTzRO?=
 =?utf-8?B?dzU5NG1mMlNldFJ0TGZFQlMrcWl6RlVxVG9YQXpDVnZZc0NybkE5Wk55M3FK?=
 =?utf-8?B?MzBzTUM0ZFJsdEFEQWRNZFY3UUpiSm0vdG14SzdPZmpBK0VNL3pmUjF0UUYz?=
 =?utf-8?B?YjlPeklpOUlHSDJkR25QTSsySXlTZzZiWlNWNUI1UzNqdk9aTEpmdHBaRFIr?=
 =?utf-8?B?OFlTMFNuU2JqK01oNllGdzBjSkNkam0ySzh0dW1qTEpHSWdRaC9IRGo5L0Fp?=
 =?utf-8?B?dVlHZVg4M2NNSXhJcXZNeVNHMDFsUzFTREJIU250aFRuY1JSendQN1FGakdK?=
 =?utf-8?B?K2V3OStCbmRVckpyaVg5QnBrSXRUelVNS29KRUY2L1pCbU1nYVlzcXhzZ05R?=
 =?utf-8?B?Q1gxRDIxS2h5ZjFHcXd3L1pxVlpCQjlHN2pDN2RtWXBldzZ4eXJMK0ZsMnlV?=
 =?utf-8?B?N3picXlzVkhHU2VuckV6U1FBeWsrbXV6ekJjb1FoaXcvN21YL0JvSi9zNTJN?=
 =?utf-8?B?Wk4yKzBYa3RjeTg2bitvdHJLamdYUTgvMkcrZjJwWEtWbjdyK3pGV3hpeWVy?=
 =?utf-8?B?cDdjbEUrUGo5Y2R3U2dYNEs4bUQyejE0eTE1NVJoWkRUbkFjcEEyOFFXamZL?=
 =?utf-8?B?bzZtcWxCQnhnLzhUNmZZSUE4N0JqREJmSXphTWFxQXRpWUtHMy9ncndoZHcw?=
 =?utf-8?B?aWUvaXVxdUlMRnBkUnNsY09JdjN2M0JaNDlGMkNTOU5rL0NUWUNhdU9kamxr?=
 =?utf-8?B?S3FSRUpNalAzL3N3dy9yZ0VqQVBXUkhJcUVLWnpwU2EybGc1YWltYUMzankx?=
 =?utf-8?B?R2hlYjJlbkRsZ0M0OXh1OXlwb1lYTDlLNzg2SHJVbGhRVno2TXR1LyszZE9I?=
 =?utf-8?B?RnRQVjdZV1l0a1BORURsUTdobjZRRUdMVGRaWlZIWnJmQnpIWVlCREI3ZU5u?=
 =?utf-8?B?WWZma3lOWTdxN1h6S01EbHYwejFUMWVaVDlIZ3hjNERoZ2h1bE9JODBBdWd4?=
 =?utf-8?B?VWQ3eTJIV0NpRVorQ0FRRmFzMDlHeFJ5UzVldy9ETkduMUtSRkgyaG4vWGZX?=
 =?utf-8?B?SXBBdXo1V3hpMzRQWjB3aEZsMWplRmh3bmZIWVA3VWJJeTRGaU1RMThkSnBx?=
 =?utf-8?B?cTBlcE14MzVUaDV3R0RYdDlXdHo5UFRvZlZ1K3lDU0h0US9ORnFLWmw4bUFZ?=
 =?utf-8?B?cjJPZ0QrZzFLaHlQaUhQMXVoTGpkWGRSazFsSkhtUWZUK1JNQW4zOGExekZF?=
 =?utf-8?B?bDdOMVhXTEpmWHE4TG1Ja29OYnRnbWNEdW56VndUdXkwRHdCcy91MVJmQmlm?=
 =?utf-8?B?VHlkWUpIbG1qUXVkaU5KeVRqcDVSMW44aDRhMmc1ODhSVkEyQnlsQ2g1MVZZ?=
 =?utf-8?B?QW16L2VwUURqL2NWSzFIZHRIT3Jsc1pOWVEwWFVJemVpaksrTEtUam5Mcnd5?=
 =?utf-8?B?NkdIaDRHUSt3enR0RXBmUGhiVFVSNGFKdDFLWGppOCtUV3cvRXd3bjQ2UjFB?=
 =?utf-8?B?MWpuV1RKTmg4YXNxelJRQjFLbE1ySUFjeTEweDZ6YUNhb0k2OVdGaHJyNkIx?=
 =?utf-8?B?WGhBNEgxYXpNcGI2ZUpjcnlKQ1VzV01wcS93ZUZKNldqcVVnVUROb1pXQzhz?=
 =?utf-8?B?bXgxY2ErQVZCMGJMWjRDWUx4NXBNejFGMllIVWxkL1NCZllHVS9FN084aldY?=
 =?utf-8?B?Q3g1Yjg3ZklvVXZtYkY1ckJKTDFObDRjSExCYkJwUHI1bGc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbec1f3-e1a0-4c62-1bcb-08df457d343a
X-MS-Exchange-CrossTenant-AuthSource: DB5PR09MB8796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:06:56.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4069
Received-SPF: pass client-ip=2a01:111:f403:d207::1;
 envelope-from=casasfernando@outlook.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I just ran into this issue after upgrading my Alpine Linux 
virtualization host from 3.23.4 (kernel 6.18.22 / QEMU 10.1.5) to 3.24.4 
(kernel 6.18.60 / QEMU 11.0.3).

As a workaround, I can confirm that disabling |iothread| for the guest 
VMs makes the problem go away.

While this might seem like a cosmetic issue at first, it has a 
significant impact on host monitoring. The consistently high iowait 
values trigger false alarms and make it harder to distinguish actual 
storage I/O problems from this reporting issue. Simply ignoring these 
alerts could potentially cause genuine storage issues to go unnoticed.

I'm also adding Natanael to the thread for awareness, as he maintains 
the QEMU packages for Alpine Linux.

Thanks for looking into this!

Fernando



