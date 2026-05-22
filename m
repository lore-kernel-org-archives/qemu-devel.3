Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28D5CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWVd-0005Yj-1R; Fri, 22 May 2026 16:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWVV-0005W3-Iz; Fri, 22 May 2026 16:30:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWVR-0005R3-KY; Fri, 22 May 2026 16:30:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIUCjf3120487; Fri, 22 May 2026 20:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hM+tGK
 HJ8FGF8doGEPbkCKeMqdk3wu+ndVgIa8v7Jp0=; b=hoWxMZta5uUoyfbfVl/p4G
 4CN4VAH/uJ6gdVOYOG4YSHXdA37Clly1FvFtFtYQw90las68M21vidLCeHomNtm0
 J86Y1IEEj6winNh2IFJ1kzJvpUDZKtx8iiVJ8HHMnyvLaWvkxSC+Gp3PCjXhgQKC
 TUfZfKIE1TDBuMQCpF1w/WnpoZUNg+k9AgKTed9ZMiZiCZe9Jpi9epglbX4D4wxy
 iqN2KquD2Uj02JwTNp0rjmhR0GA36kBpfjRujU8WyAxoF7aL95dJkkWSny5Fgu4s
 +FcPfm4+mc6EzulBLyGK8j9ccbUiYWZMBhByotlx1dhpvUV511Ap5vduJri4Ew0w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n5rht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:30:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MKO3Zl011547;
 Fri, 22 May 2026 20:30:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqjs86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:30:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MKTxiw22610610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:29:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13FC05805F;
 Fri, 22 May 2026 20:29:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20AA65805B;
 Fri, 22 May 2026 20:29:57 +0000 (GMT)
Received: from [9.67.42.213] (unknown [9.67.42.213])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 20:29:57 +0000 (GMT)
Message-ID: <8b292b73-eded-4c73-a561-caf9864aa01c@linux.ibm.com>
Date: Fri, 22 May 2026 16:29:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 09/32] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-10-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pa7giLcSSO_LhzZXEQOfTxN6klDBl8uy
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a10bcc9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=z4m_pwUO0LSHv-M1JlwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Pa7giLcSSO_LhzZXEQOfTxN6klDBl8uy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfXzYGWW0/GzKPl
 7sBSeD4QRyPsJhHSmyGLGUe2saSeN+IS623pB308glJe8Y5DtpSF+8s2mLcJMrw7S13E7/L+qMc
 L9F03IMX0FDGanFYbC0qz8vpMerCzKysBkqxtlcRwnCBvAflb0Vr1g5Ry6RXCk6VTgiiH7L2nGY
 D3+6h9jChD1IjD+6S4EH7H7S8yjA5O8TIrBo5lN4QcIgjShc5J/KgzuMfAQw1nlODobRBHxtORB
 m5i4yGBt0NGLzz5qwpGIWGIJaMDUDoNmil2bZBpr1hElKD+UXicJrmUmlzEhUj+c75AF5RkCVUu
 Yat7ITnps68fsxZs/ihsWQIJXavWR63KRcBdiYr/EBwN8BBu44PPT2DCC58yUSlQrm2t9qL8gb5
 JULkg5CSr8Z8pyeldyiUMx2zvhvB4V2OLmUaJl2pEMaxRVhc9G7jVqjUsKtJpT1b31fsbXHsptN
 2dh0ESz4hIWnUfOj8Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220200
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/5/26 16:18, Zhuoying Cai wrote:

[...]

> +
> +#define DIAG_320_VCE_FLAGS_VALID                0x80
> +#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
> +#define DIAG_320_VCE_KEYTYPE_ECDSA_P521         1> +#define DIAG_320_VCE_FORMAT_X509_DER            1
> +#define DIAG_320_VCE_HASHTYPE_SHA2_256          1

The key types, format, and hash types might be good as enumerations.
It'd be especially helpful when going through the debugger and seeing
explicit values printed out.

[...]

> +
> +static int build_vce_header(VCEntry *vce, const S390IPLCertificate *cert, int idx)
> +{
> +    int key_type;
> +
> +    vce->vce_hdr.len = cpu_to_be32(sizeof(VCEntryHeader));
> +    vce->vce_hdr.cert_idx = cpu_to_be16(idx + 1);
> +    memcpy(vce->vce_hdr.name, cert->name, CERT_NAME_MAX_LEN);
> +
> +    key_type = get_key_type(cert);
> +    if (key_type == -1) {
> +        return -1;
> +    }

Move the is_cert_valid check to here.

> +    vce->vce_hdr.key_type = key_type;
> +
> +    return 0;
> +}
> +

[...]

> +
> +    for (int i = cs_start_index; i <= cs_end_index; i++) {
> +        VCEntry *vce;

What about using g_autofree here and then removing the g_free's below?

> +        const S390IPLCertificate *cert = &cs->certs[i];
> +
> +        /*
> +         * Bit 0 of the VCE flags indicates whether the certificate is valid.
> +         * The caller of DIAG320 subcode 2 is responsible for verifying that
> +         * the VCE contains a valid certificate.
> +         */
> +        vce = diag_320_build_vce(cert, i);
> +
> +        /*
> +         * If there is no more space to store the cert,
> +         * set the remaining verification cert count and
> +         * break early.
> +         */
> +        if (remaining_space < vce->vce_hdr.len) {
> +            vcb->vcb_hdr.remain_ct = cpu_to_be16(last_vc_index - i);
> +            g_free(vce);
> +            break;
> +        }
> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + vcb->vcb_hdr.out_len, r1,
> +                                    vce, vce->vce_hdr.len)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            g_free(vce);
> +            return -1;
> +        }
> +
> +        vcb->vcb_hdr.out_len += vce->vce_hdr.len;
> +        remaining_space -= vce->vce_hdr.len;
> +        vcb->vcb_hdr.stored_ct++;
> +
> +        g_free(vce);
> +    }
> +    vcb->vcb_hdr.stored_ct = cpu_to_be16(vcb->vcb_hdr.stored_ct);
> +
> +out:
> +    vcb->vcb_hdr.out_len = cpu_to_be32(vcb->vcb_hdr.out_len);
> +
> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, sizeof(VCBlockHeader))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    return DIAG_320_RC_OK;
> +}

[...]

Aside from the endian conversion mentioned by Farhan, I think the rest
of this patch looks good.  I appreciate the inline comments.  It has
made coming back to these reviews a lot easier to understand your
approach :)

-- 
Regards,
  Collin

