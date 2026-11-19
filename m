Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318C606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bHlEHhBL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=buwx9HlW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU6PX-0005Ne-Pj; Thu, 19 Nov 2026 12:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU6PR-0005M6-0J
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:58:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU6PO-0000Gg-W0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:58:56 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJGrkPR1385633
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 17:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4waiPZMKL/Ghb/svH5ksFW9cuRFsB6HQFoJvGjPSaqc=; b=bHlEHhBLdC5C9uyF
 ogkgw07N9Ab+BmRE8os0j9w12lvMj1r8DwAcKDbvc8bJYrOAFHV5CYIiEz1BnEwX
 kTZLL+lygxrdvIA6L0viNoBr91h6CEYrnZH2mKOpW/hIY/siAYdyl6YfZ0P9jjEW
 CJ24l0DF9yvRFkmHzNtRsKJiyWAXLIpSK/khzp4FnU4ypSjHQuD1lzJVLfo5ZOWC
 kLTtjs6DgpyAG2OLo9JFl7FA6qo8zNEMW3+s72Rnx7oA86byGpDV09xoYaYLNA73
 G6atSDrA/3jM2CrC6sfgKpA6TXr3AVzSNgzY85tdA9qQ2pKhs6AX19tobbTVT9za
 NtHtJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x70advh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 17:58:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so12288985a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795111132; x=1795715932; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4waiPZMKL/Ghb/svH5ksFW9cuRFsB6HQFoJvGjPSaqc=;
 b=buwx9HlW6tsBZprgZKngDgOatgkuyVBHJ0QFonwgNCIycIpk9LSC2LAs2/fRBhMG/9
 a7VRRc+amw/wlk4/7rn/yZXn7YVJtAE+WUuleN8XPS0f2k3pFijzFiYzs+NpSv33fw27
 EJ0MrXWFOUqexbyvntACN/SpEtRNLc1KB5vGuTisFd7QtmRGZ6DnzKINbRKkJh9fPf1y
 us9/J5Q/+7E4voidHf/z+ngKDXsMJHmJgHGA2h0lGkoOrb2hwhqiFR0s7Em1c8Wapk18
 DqHF2G/4E1YZHQfQSKOPYkzg0wpovBT/wnWaCezZWwm7e+H1Zkq65+zLzR7mpznU8hb6
 Bw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795111132; x=1795715932;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4waiPZMKL/Ghb/svH5ksFW9cuRFsB6HQFoJvGjPSaqc=;
 b=tFzA/3disQhoetDq5Msyrvs0AuUIHyVxAvc42Cdxj6JZpGO09OOAOleEnSYwikNqQ9
 F2eaM432Y+fEzvV+fg9EK3UNaUsaBhv/QchrxK2hN2Rkygni95Yvdb/zn1b1B2nrtn1Y
 wQkUINmL4jJ++yB3mwxra5m8OZ1usRwaBX7USNL3Y9Xmp1MHktS9w+YQxGD9hZ7ZZLdG
 6YMLB8docCmqQw6EQkGvLaOmD3pCVoUI41LD6Fk9oDTec/b07lPBv76pVBH7JTqYCgid
 817q0FT3rT4m14iBNsbwGwxyZrU8tMML9EWOI/GNI8k1+nS3sM0zB5SGdisJ1dBoth41
 UZeA==
X-Forwarded-Encrypted: i=1;
 AL+hErHK1F+vzngDWLD6u1tNx5CXl3fDdczE9iRreLPPY2zXOsBCXAVeLYHSaNh90ozqJvDw5Nj0s1g89dAs@nongnu.org
X-Gm-Message-State: APuU4Z+M+lz5oTu3WJZyr9qvLlls92SmyrtVOl4nwFkjUir6Mk6WYYNh
 gAh++5UdDz6hQORYNE8Qv4j5B5J/fNfY6TYUbk0MAJ1mZjJj+AiuZ7oR2SIRs36BW4uqaWNsT6y
 mvCn91o8rJ7eHkE+TBy0tpEbhLSPLx5GEjiWBrHEWukfkj88dpPPGAayktQ==
X-Gm-Gg: AYBFou1Wg6XyOXpYXiZBmUoSheYdfKAA8O2CRz87bko+9zDS7Nr+B745BWNFAln07+j
 N552W5gFI6retAcaGeKONcavODAhcYBEjUwpVKHJxWRnrVEtqKX5ryiufICCzEtmAgmgkMwEV5w
 al/ZcI9HkDvMlFAwlW+mwcWnAnFtghJM1LrFwxaWvqhqjyBVs3+stpwfhLqwjzuKhhUQPp5sa22
 OyWPAPlQcLjYeQ645AInNgBFRl7wqWdiriw2uYxQfkQWjmfsQN0hxdP4YYMrftoJSiY+2GdkyY6
 sAt18dXsqs72SaGDQZnMEdG5PIi78g9OC5qfbW9kvNVcXIUR/cirCNjA2qFXTZKYakzxTAZ0cjS
 mqmKkFMdAN9RLKQ8g3YrLzRodpZdRmj4k8ET5SVz5f/Fo3STmhJZaoHo6eVh9DNVJ5POqnCikzo
 jxz8Ihr+4=
X-Received: by 2002:a05:620a:701c:b0:949:a254:706a with SMTP id
 af79cd13be357-949ba96eae0mr55468985a.14.1795111132172; 
 Thu, 19 Nov 2026 09:58:52 -0800 (PST)
X-Received: by 2002:a05:620a:701c:b0:949:a254:706a with SMTP id
 af79cd13be357-949ba96eae0mr55464185a.14.1795111131558; 
 Thu, 19 Nov 2026 09:58:51 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm883680f8f.34.2026.11.19.09.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 09:58:50 -0800 (PST)
Message-ID: <bf24f1a1-c795-4a40-bf3c-f684fb28353e@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:58:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
Content-Language: en-US
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, fam@euphon.net,
 pbonzini@redhat.com, amachhiw@linux.ibm.com,
 qemu-block <qemu-block@nongnu.org>
References: <20260819095855.115823-1-rathc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819095855.115823-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KZ6v3guib2CiQI_cM2vW6p-1Fdez3FpW
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6aff38dc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=eLGE-lYFzjDE4tTs6sYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3MSBTYWx0ZWRfX3sHFSRg4vm0I
 5nsJqXsI75EVzfI4rrBJbyiwsu1y8ivoUaFsYoRVU5cPyr/1DFfAO3AT8/utId3M3FwxVFHzSM9
 nRYYRIxEApmMutb+KXp8qfoEv5PqxCs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3MSBTYWx0ZWRfXw85IsR7RyLMA
 Ry9gRlQxAPxACsxF0q8NAtyAJ6XyKoq7RAHHqmXku0FkKVMRiscHeMgmTwsLIpv/qwwY+MxeUIc
 E9YjMIf/VR8q98HbE74Q1CL02J+VbRzOH3J9F/A2tw3GLNbr50mEhicZPBsgzmd7Y7ZwsJdAUzD
 a0tHNmMZI4/+uYqivKKeC4ZLd+n8NfF38qjh2K1qFBAqTrKpnYzDQ2u+NHokOSVhQPdSHmkXW95
 YJ6egTd/ovXYQqTJsdiMzLDJNHpPCMQw40nJYPKuK27K9EEyfD4uIBWuC20Lua8aL28h/5zmS/P
 BmsV3R0QFhMcroSv0bdWx3NI6Sobaj91noo9wUt4N4UMCthQvPBTPb5bY+81CPWe7KvF0/mXMms
 E+EIP2l9FgIGiiJTk8o367lOK3x+AsGVx+nqxxAVERDP9t22MWtU60PL6tfVe7Ge9KqbxlcRhRn
 B0GacIAXMuB1c3W8MoQ==
X-Proofpoint-GUID: KZ6v3guib2CiQI_cM2vW6p-1Fdez3FpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chinmay,

On 19/8/26 11:58, Chinmay Rath wrote:
> cdb_offset and local_desc values are dependent on the guest. If the value
> is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().
> 
> Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
> bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.
> 
> Make all callers of vscsi_preprocess_desc() check its return value and
> handle failure accordingly.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index b4c8f94d22..9fef224727 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
>   static int vscsi_preprocess_desc(vscsi_req *req)
>   {
>       struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
> +    /* bytes available for descriptors behind srp_cmd.add_data */
> +    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, add_data);
>   
>       req->cdb_offset = cmd->add_cdb_len & ~3;
>   
> @@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
>       case SRP_NO_DATA_DESC:
>           break;
>       case SRP_DATA_DESC_DIRECT:
> +        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: direct desc out of bounds\n");

Please replace fprintf() by qemu_log...(GUEST_ERRORS, ...).

> +            return -1;
> +        }
>           req->total_desc = req->local_desc = 1;
>           break;
>       case SRP_DATA_DESC_INDIRECT: {
> -        struct srp_indirect_buf *ind_tmp = (struct srp_indirect_buf *)
> -                (cmd->add_data + req->cdb_offset);
> +        struct srp_indirect_buf *ind_tmp;
> +
> +        if (req->cdb_offset + sizeof(struct srp_indirect_buf) > avail) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: indirect desc out of bounds\n");

Ditto.

> +            return -1;
> +        }
> +        ind_tmp = (struct srp_indirect_buf *)(cmd->add_data + req->cdb_offset);
>   
>           req->total_desc = be32_to_cpu(ind_tmp->table_desc.len) /
>                             sizeof(struct srp_direct_buf);
>           req->local_desc = req->writing ? cmd->data_out_desc_cnt :
>                             cmd->data_in_desc_cnt;
> +
> +        /* desc_list[] entries must also fit inside the IU buffer */
> +        if (req->local_desc * sizeof(struct srp_direct_buf) >
> +            avail - req->cdb_offset - sizeof(struct srp_indirect_buf)) {
> +            fprintf(stderr,
> +                    "vscsi_preprocess_desc: local_desc out of bounds\n");

Ditto.

> +            return -1;
> +        }
>           break;
>       }
>       default:
> @@ -725,7 +746,11 @@ static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
>       memcpy(&resp_data[8], "QEMU    ", 8);
>   
>       req->writing = 0;
> -    vscsi_preprocess_desc(req);
> +    if (vscsi_preprocess_desc(req) < 0) {
> +        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> +        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
> +        return;
> +    }
>       rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
>       if (rc < 0) {
>           vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> @@ -775,7 +800,12 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
>           i += 8;
>       }
>   
> -    vscsi_preprocess_desc(req);
> +    if (vscsi_preprocess_desc(req) < 0) {
> +        g_free(resp_data);
> +        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
> +        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
> +        return;
> +    }
>       rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
>       g_free(resp_data);
>       if (rc < 0) {
> @@ -823,7 +853,10 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
>           req->writing = (n < 1);
>   
>           /* Preprocess RDMA descriptors */
> -        vscsi_preprocess_desc(req);
> +        if (vscsi_preprocess_desc(req) < 0) {

scsi_req_cancel() does not send an SRP response by itself,
so now guest waits until timeout... (That makes me wonder
how this patch was tested). In order to return a proper error
to the guest, please add:

                req->dma_error = true;

> +            scsi_req_cancel(req->sreq);
> +            return 1;
> +        }
>   
>           /* Get transfer direction and initiate transfer */
>           if (n > 0) {


