Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08206E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIOp-0008Tf-QL; Tue, 03 Feb 2026 10:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vnIOn-0008NP-R8
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:33:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vnIOl-0004my-VN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:33:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6139WDtT016796;
 Tue, 3 Feb 2026 15:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TQKi2a
 m5oZcgIHaq8eQaj00/wo7enqjS2FdBn8oU1nQ=; b=QcRho1A2jCVrvOmiA92w/K
 oTVT4SDlW/zGHRY3qCeJMU6lhq0JK0V2IKKbsgKSwAUYRhFp+SGRoWp2kwIVv5p8
 FWnX3iRYK/iu9tpLhQlHqmdU5bWULICeBel+74DIbhKVCJ84e/CdKudMWrbb/s+s
 61WaqmsAVJsJGPl1ouAUxjc3dBN3yPp5IXhOPW1rBUShOTVHoYpVon04cAEB0CJC
 m74sFSCU5N2PyeJJP+feANhnxxU2oBWqJYyshJsQzvbPMvyUV/JJg2WFRsY2/z20
 nAuaKI90RNDQZ7IRtv8cKCv5Rri388xsDTtFq7Yes0jUL9a3UjC8jZarY9dqlzYg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt613x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:33:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613C7GFD005996;
 Tue, 3 Feb 2026 15:33:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9j9dmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 15:33:01 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 613FX0CV14746268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Feb 2026 15:33:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95F895805E;
 Tue,  3 Feb 2026 15:33:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF39558058;
 Tue,  3 Feb 2026 15:32:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Feb 2026 15:32:59 +0000 (GMT)
Message-ID: <6d0b4330-1aba-4f2e-968d-1d64397241de@linux.ibm.com>
Date: Tue, 3 Feb 2026 10:32:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tpm_emulator: drop direct use of errno variable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20260201172746.404481-1-vsementsov@yandex-team.ru>
 <20260201172746.404481-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260201172746.404481-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMyBTYWx0ZWRfX7kEecgRIIgU5
 lUW7AJaaEGEs53udSMYv3/R9DEiGFjSduPjOb6hpEXTWBtOVMeM1ZMGSB0aB5C3b1LM/Y1FgPjK
 bJ4gUkRbCVi909oyRhk89533na0JUFOsW0A8ULqDSflkAIuWp2Sm5jpPpEaTz6jk2Ans/1eRUx9
 LsuEzCUKRUJ+Fkc+ZU0IDkvFSI8NNUCXGktXB2nrOT9xD31P/HsAtUqQWUH4DkKdyHqqRP3P8u0
 /nOipT35GZtw2lU4LFrx7luyHBY2SGMBpTlMQLu/J3UzaEiIxN4qPTr79PiQb631FecRoGAi+mZ
 jf2JDe94b654aBIp0LL2jac7jH9nO/rnFMimhcnGJH3y/MI0TJI8CSafVYfldQxKH5K+vsy7Nv2
 VprCS9dIWR0TOPku+ZtFiBbB/+vrGI48zUZiOUPlXJIQNX0zma+lkb4jTXA7YxWnFMykO2Ck2ss
 X0Kx413L9h9HG8+lpgg==
X-Proofpoint-GUID: 5APv9dC5jrTjF8ftoXgNthnw1OwQDKiP
X-Proofpoint-ORIG-GUID: 5APv9dC5jrTjF8ftoXgNthnw1OwQDKiP
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=6982152e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=myy8jjzOfpeVxhzBBLUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602030123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/1/26 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> The code tends to include errno into error messages after
> tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.
> 
> Both has error paths, where errno is not set, examples:
> 
> tpm_emulator_ctrlcmd()
>    qemu_chr_fe_write_all()
>      qemu_chr_write()
>        replay_char_write_event_load()
>          ...
>          *res = replay_get_dword();
>          ...
> 
> tpm_util_test_tpmdev()
>    tpm_util_test()
>      tpm_util_request()
>        ...
>        if (n != requestlen) {
>            return -EFAULT;
>        }
>        ...
> 
> Both doesn't document that they set errno.
> 
> Let's drop these explicit usage of errno. If we need this information,
> it should be added to errp deeper in the stack.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -539,8 +535,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
>       /* FIXME: make the function non-blocking, or it may block a VCPU */
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
>                                sizeof(ptm_res), sizeof(res)) < 0) {
> -        error_report("tpm-emulator: Could not cancel command: %s",
> -                     strerror(errno));
> +        error_report("tpm-emulator: Could not cancel command: %s");

Remove the '%s'.

I get these build errors now:

../backends/tpm/tpm_emulator.c: In function ‘tpm_emulator_cancel_cmd’:
../backends/tpm/tpm_emulator.c:538:22: error: format ‘%s’ expects a 
matching ‘char *’ argument [-Werror=format=]
   538 |         error_report("tpm-emulator: Could not cancel command: %s");
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../backends/tpm/tpm_emulator.c: In function ‘tpm_emulator_post_load’:
../backends/tpm/tpm_emulator.c:958:9: error: unused variable ‘ret’ 
[-Werror=unused-variable]
   958 |     int ret;
       |         ^~~
cc1: all warnings being treated as errors




