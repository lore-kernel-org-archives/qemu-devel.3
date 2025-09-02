Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DF6CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVEo-0004DU-Qs; Tue, 02 Sep 2025 13:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1utVEh-0003xd-6F; Tue, 02 Sep 2025 13:56:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1utVEf-0003Pc-7J; Tue, 02 Sep 2025 13:56:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582CW2Ra009463;
 Tue, 2 Sep 2025 17:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7S6FoM
 Kk+0H5DGQEC9q7t1oM7Of/Tdz28F3+JhYmkIg=; b=Uy+jVc+6aUXybKiOsT5fwb
 hkhUkmh1d0hCLtDVIngCtipAtVzrQJmsg6TEhQAcKmxOVQwWPnk6e7o4XIomOh45
 LkI0ZSvVFDmO1Jef7kXSMrfm/fvqQ4fnuy9M0RVbIMe6DGT9ZHYptlH0w+tgx/Ye
 auGbb2JSZXc9jd7MDSDBQYT0U/PvLcPptsFGq85LuxHebWgtYpsOp1Xaf/Xmk4GE
 Vz55bcODVnG7wDxuB9vI/AmfAXIKCjnCVE4y0xHSq0PD8MeqfsWmAIFGGAIQ/xYD
 5PsnHW/t2y9g7oT4iVtjCOsnDCO+5Qx5sf/Z9vW9D5HIkVHNSrfz12ydajrVMciA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvfqr6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Sep 2025 17:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582H8SAI009248;
 Tue, 2 Sep 2025 17:55:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumbm6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Sep 2025 17:55:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 582Htbtd10356172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Sep 2025 17:55:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00E0858052;
 Tue,  2 Sep 2025 17:55:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE52058056;
 Tue,  2 Sep 2025 17:55:35 +0000 (GMT)
Received: from [9.61.18.35] (unknown [9.61.18.35])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  2 Sep 2025 17:55:35 +0000 (GMT)
Message-ID: <e3c840c5-3549-471f-92b5-d82b9b5a53a5@linux.ibm.com>
Date: Tue, 2 Sep 2025 13:55:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/29] hw/s390x/ipl: Create certificate store
To: Jared Rossi <jrossi@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-5-zycai@linux.ibm.com>
 <f799baba-1c27-46ab-b6a9-5e88144a8947@linux.ibm.com>
 <7d28e791-63ce-4d5f-9803-8f0dc140b594@linux.ibm.com>
 <2b0476e1-97e1-4592-b70e-4f27f8695833@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <2b0476e1-97e1-4592-b70e-4f27f8695833@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b72f9a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=-fShbzbibhp5TB0pn3EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P8VJMImll7iN-_qRy505sqlPQhq4qvh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXxtZ26b2eSfsZ
 1c4Q9+sVqjv6SQtT1hRR4f2xsBvaMk/dqdt/8FoI73/hHjZi7RYtRSRXWA1rrQHVSFGZIE9wPYj
 osd4ytTRXmxQijADBfiwSFudukiok+ZsRsR+evI4sXHPWFse4hnoRfbRSF9NUCkcwrRa7Gg8FB1
 uiw1H1YZDqqYvDyfErgC5/30sLGpo0X94CnAUbAIlUeEBrGYuv+JJL3CZFGspfNfuERMfFnfVib
 xrqbxiNPWBb6tmE5BEwcMl/DobJuSrluA948tHQIMv7MiWFVemIQKBss2yAABnw4RvRYkdeIRfg
 Y6XoJuK7vXqF2ch4mYkyLexkwtrtznN1D3yh3Pg3seph2bLvM145Z1vBGPDQSdAIJ+73M2k9Egw
 tOpso4h6
X-Proofpoint-GUID: P8VJMImll7iN-_qRy505sqlPQhq4qvh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 9/2/25 11:15 AM, Jared Rossi wrote:
> 
> 
> On 8/28/25 10:46 AM, Zhuoying Cai wrote:
>> On 8/27/25 7:14 PM, Farhan Ali wrote:
>>> [snip...]
>>>
>>> +
>>> +static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw, Error **errp)
>>> +{
>>> +    S390IPLCertificate *q_cert = NULL;
>>> +    g_autofree uint8_t *cert_der = NULL;
>>> +    size_t der_len = size;
>>> +    int rc;
>>> +
>>> +    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, errp);
>>> +    if (rc != 0) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    q_cert = g_new0(S390IPLCertificate, 1);
>>> +    q_cert->size = size;
>>> +    q_cert->der_size = der_len;
>>> +    q_cert->key_id_size = QCRYPTO_HASH_DIGEST_LEN_SHA256;
>>> +    q_cert->hash_size = QCRYPTO_HASH_DIGEST_LEN_SHA256;
>>> +    q_cert->raw = raw;
>>> +
>>> +    return q_cert;
>>> +}
>>> +
>>> +static S390IPLCertificate *init_cert(char *path)
>>> +{
>>> +    char *buf;
>>> +    size_t size;
>>> +    char vc_name[VC_NAME_LEN_BYTES];
>>> +    g_autofree gchar *filename = NULL;
>>> +    S390IPLCertificate *qcert = NULL;
>>> +    Error *local_err = NULL;
>>> +
>>> +    filename = g_path_get_basename(path);
>>> +
>>> +    size = cert2buf(path, &buf);
>>> +    if (size == 0) {
>>> +        error_report("Failed to load certificate: %s", path);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    qcert = init_cert_x509(size, (uint8_t *)buf, &local_err);
>>> +    if (qcert == NULL) {
>>> +        error_reportf_err(local_err, "Failed to initialize certificate: %s:  ", path);
>>> +        g_free(buf);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    /*
>>> +     * Left justified certificate name with padding on the right with blanks.
>>> +     * Convert certificate name to EBCDIC.
>>> +     */
>>> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
>>> +    ebcdic_put(qcert->vc_name, vc_name, VC_NAME_LEN_BYTES);
>>> +
>>> +    return qcert;
>>> +}
>>> +
>>> +static void update_cert_store(S390IPLCertificateStore *cert_store,
>>> +                              S390IPLCertificate *qcert)
>>> +{
>>> +    size_t data_buf_size;
>>> +    size_t keyid_buf_size;
>>> +    size_t hash_buf_size;
>>> +    size_t cert_buf_size;
>>> +
>>> +    /* length field is word aligned for later DIAG use */
>>> +    keyid_buf_size = ROUND_UP(qcert->key_id_size, 4);
>>> +    hash_buf_size = ROUND_UP(qcert->hash_size, 4);
>>> +    cert_buf_size = ROUND_UP(qcert->der_size, 4);
>>> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
>>> +
>>> +    if (cert_store->max_cert_size < data_buf_size) {
>>> +        cert_store->max_cert_size = data_buf_size;
>>> +    }
>>> +
>>> +    cert_store->certs[cert_store->count] = *qcert;
>>> +    cert_store->total_bytes += data_buf_size;
>>> +    cert_store->count++;
>>> +}
>>> +
>>> Do we need to free qcert here after we copied the contents to
>>> cert_store->certs[cert_store->count]? Also AFAIU we copy the certificate
>>> file contents into QEMU memory, but don't free it. Just wanted to
>>> clarify, do we need the file contents in QEMU memory for ccw-bios and
>>> guest kernel use? Thanks Farhan
>>>
>>>
>> Yes, the file contents need to remain in QEMU memory for both ccw-bios
>> and guest kernel use.
>>
>> * ccw-bios: The certificate used to verify the component is retrieved in
>> the BIOS via DIAG320, with its address stored in the IPL Information
>> Report Block.
>>
>> * guest kernel: Certificates can also be retrieved via DIAG320 and made
>> available to the guest kernel keyring.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8cf57d7217c32133d25615324c0ab4aaacf4d9c4
> Something still doesn't seem right to me.  As far as I can tell the cert 
> store will be reinitialized each time the guest reboots, which sounds 
> like it will cause problems if there is no corresponding free somewhere.
> 
> What is the expected behavior during a reboot?  Should the guest A)  
> parse the cert paths again and reinitialize, or B)  read the entries in 
> the previously created cert store?
> 
> If A, then the cert store needs to be cleared/freed in some way each time.
> 
> If B, then the cert store should not be reinitialized.
> 
>> [snip...]
> Regards,
> Jared Rossi

I think option B sounds more accurate. Since the cert store can't be
modified during reboot, it's reasonable to read from the previously
created cert store.


